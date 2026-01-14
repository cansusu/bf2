// High-performance FPGA MD4 hash cracking pipeline
#![feature(once_cell_get_mut)]
#![feature(sync_unsafe_cell)]
#![feature(portable_simd)]
mod xdma;
mod ring;
mod md4;
mod phf;

use std::mem::size_of;
use std::thread;
use std::time::Instant;
use std::sync::atomic::{AtomicBool, AtomicU64, Ordering};
use std::sync::Arc;
use std::io::Read;
use std::fs::File;
use std::io::Write;


const QDEPTH: usize = 1024;
const HASH_THREADS: usize = 8; 
const SLOT_DEPTH: usize = 64;
const TRAIL_LEN: usize = 4; // pw length = TRAIL_LEN + 1
const FILTER_SIZE: usize = 2048;

struct BloomFilter<const N: usize> {
    filter: [u16; N],
    k: u32,
}

#[derive(Debug, Copy, Clone, Default)]
pub struct Stats {
    pub cycles: u32,
    pub stall_cycles: u32,
}


#[derive(Debug, Copy, Clone, Default)]
struct RaplReading {
    package_uj: u64,
    package_max_uj: u64,
    cores_uj: u64,
    cores_max_uj: u64,
    dram_uj: u64,
    dram_max_uj: u64,
}

pub fn fpga_read_stats(dev: &xdma::XDMA) -> std::io::Result<Stats> {


    let (upper0, lower) = loop {
        let upper0 = dev.read_reg(0x40000000)?;
        let lower  = dev.read_reg(0x40010000)?;
        let upper1 = dev.read_reg(0x40000000)?;
        if upper0 == upper1 {
            break (upper0, lower);
        }
    };

    let clk_ctr: u32 =
        (upper0 & 0xFFFF_0000) | ((lower & 0xFFFF_0000) >> 16);

    let stall_ctr: u32 =
        ((upper0 & 0x0000_FFFF) << 16) | (lower & 0x0000_FFFF);

    Ok(Stats {
        cycles: clk_ctr,
        stall_cycles: stall_ctr,
    })
}


fn read_u64_sysfs(path: &str) -> std::io::Result<u64> {
    let s = std::fs::read_to_string(path)?;
    let v = s.trim().parse::<u64>()
        .map_err(|e| std::io::Error::new(std::io::ErrorKind::InvalidData, e))?;
    Ok(v)
}

fn energy_path_to_max_path(energy_path: &str) -> String {
    energy_path.replace("/energy_uj", "/max_energy_range_uj")
}

fn read_rapl_energy() -> std::io::Result<RaplReading> {
    const PKG: &str  = "/sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj";
    const CORE: &str = "/sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj";
    const DRAM: &str = "/sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:2/energy_uj";

    let package_uj = read_u64_sysfs(PKG)?;
    let package_max_uj = read_u64_sysfs(&energy_path_to_max_path(PKG)).unwrap_or(0);

    let (cores_uj, cores_max_uj) = match read_u64_sysfs(CORE) {
        Ok(v) => (v, read_u64_sysfs(&energy_path_to_max_path(CORE)).unwrap_or(0)),
        Err(_) => (0, 0),
    };

    let (dram_uj, dram_max_uj) = match read_u64_sysfs(DRAM) {
        Ok(v) => (v, read_u64_sysfs(&energy_path_to_max_path(DRAM)).unwrap_or(0)),
        Err(_) => (0, 0),
    };

    Ok(RaplReading {
        package_uj, package_max_uj,
        cores_uj, cores_max_uj,
        dram_uj, dram_max_uj,
    })
}

fn delta_uj(start: u64, end: u64, max: u64) -> u64 {
    if end >= start {
        end - start
    } else if max > 0 {
        (max - start) + end
    } else {
        0
    }
}

fn uj_to_j(uj: u64) -> f64 {
    (uj as f64) / 1_000_000.0
}




impl<const N: usize> BloomFilter<N> {
    pub fn from_hashes(data: &Vec<[u32; 4]>) -> BloomFilter<N> {
        let bits = N * 16;
        let mut filter = [0u16; N];
        let k = Self::optimal_k( u64::try_from(data.len()).expect("Cannot cast usize to u64"), u64::try_from(N).expect("Cannot cast usize to u64") * 16); 
        let kusize = usize::try_from(k).expect("Cannot cast u32 to usize");

        for &h in data {
            let (_, hash, _) = unsafe {h.align_to::<u8>()};
            let mut high = 0u64;
            let mut low = 0u64;
            for b in 0..8 {
                high = (high << 8) | (hash[b] as u64);
                low = (low << 8) | (hash[b + 8] as u64);
            }
            let h = ((high as u128) << 64) | (low as u128);
            let mut indices = [0u64; 15];

            match N {
                64 => {
                    for n in 0..kusize {
                        if n < 12 {
                            indices[n] = ((h >> (n * 10)) & 0x3ff) as u64;
                        } else {
                            let high_shift = 120 - (n - 12);
                            let high = ((h >> high_shift) & 0xff) as u64;
                            let low = ((h >> (n * 10)) & 0x3) as u64;
                            indices[n] = (high << 2) | low;
                        }
                    }
                },
                128 => {
                    for n in 0..kusize {
                        match n {
                            0..12 => {
                                let start_bit = n * 10;
                                indices[n] = ((h >> start_bit) & 0x7ff) as u64;
                            },
                            12 => {
                                let high = ((h >> 119) & 0x1ff) as u64;
                                let low = (h & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            13 => {
                                let high = ((h >> 118) & 0x1ff) as u64;
                                let low = ((h >> 10) & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            14 => {
                                let high = ((h >> 117) & 0x1ff) as u64;
                                let low = ((h >> 20) & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            _ => unimplemented!(),
                        }
                    }
                },
                256 => {
                    for n in 0..kusize {
                        match n {
                            0..12 => {
                                let mut start_bit = (10 * n) + 1;
                                if n == 0 {start_bit = 0;}
                                indices[n] = ((h >> start_bit) & 0xfff) as u64;
                            },
                            12 => {
                                let high = ((h >> 118) & 0x3ff)  as u64;
                                let low = (h & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            13 => {
                                let high = ((h >> 117) & 0x3ff) as u64;
                                let low = ((h >> 10) & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            14 => {
                                let high = ((h >> 116) & 0x3ff) as u64;
                                let low = ((h >> 20) & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            _ => unimplemented!(),
                        }
                    }
                },
                512 => {
                    for n in 0..kusize {
                        match n {
                            0..12 => {
                                let start_bit = n * 10;
                                indices[n] = ((h >> start_bit) & 0x1fff) as u64;
                            },
                            12 => {
                                let high = ((h >> 117) & 0x7ff) as u64;
                                let low = (h & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            13 => {
                                let high = ((h >> 116) & 0x7ff) as u64;
                                let low = ((h >> 10) & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            14 => {
                                let high = ((h >> 115) & 0x7ff) as u64;
                                let low = ((h >> 20) & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            _ => unimplemented!(),
                        }
                    }
                },
                1024 => {
                    for n in 0..kusize {
                        match n {
                            0..12 => {
                                let start_bit = 10 * n;
                                indices[n] = ((h >> start_bit) & 0x3fff) as u64;
                            },
                            12 => {
                                let high = ((h >> 116) & 0xfff) as u64;
                                let low = (h & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            13 => {
                                let high = ((h >> 115) & 0xfff) as u64;
                                let low = ((h >> 10) & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            14 => {
                                let high = ((h >> 114) & 0xfff) as u64;
                                let low = ((h >> 20) & 0x3) as u64;
                                indices[n] = (high << 2) | low;
                            },
                            _ => unimplemented!(),
                        }
                        indices[n] &= (bits - 1) as u64;
                    }
                },
               2048 => {
    for n in 0..kusize {
        match n {
            0..12 => {
                let start_bit = n * 10;
                indices[n] = ((h >> start_bit) & 0x7fff) as u64;
            }

            12 => {
                let high = ((h >> 115) & 0x1fff) as u64; 
                let low  = (h & 0x3) as u64;            
                indices[n] = (high << 2) | low;
            }
            13 => {
                let high = ((h >> 114) & 0x1fff) as u64;
                let low  = ((h >> 10) & 0x3) as u64;
                indices[n] = (high << 2) | low;
            }
            14 => {
                let high = ((h >> 113) & 0x1fff) as u64;
                let low  = ((h >> 20) & 0x3) as u64;
                indices[n] = (high << 2) | low;
            }

            _ => unimplemented!(),
        }

        indices[n] &= (bits - 1) as u64;
    }
}


                _ => unimplemented!(),
            }

            for j in 0..kusize {
                let bloom_idx = bits - 1 - usize::try_from(indices[j])
                    .expect("Cannot cast u64 to usize");
                filter[bloom_idx / 16] |= 1 << (15 - (bloom_idx % 16));
            }
        }

        for i in 0..(N / 2) {
            let tmp = filter[i];
            filter[i] = filter[N - 1 - i];
            filter[N - 1 - i] = tmp;
        }

        BloomFilter{filter, k}
    }

    fn optimal_k(num_hashes: u64, filter_bits: u64) -> u32 {
        if num_hashes == 0 {
            return 1;
        }
        let k_real = (filter_bits as f64) / (num_hashes as f64) * 2.0f64.ln();
        let k = k_real.round() as u32;
        return k.clamp(1, 15);
    }

    pub fn program(&self, xdma: &xdma::XDMA) -> std::io::Result<()> {
        // Set k for bloom filter
        xdma.write_reg(0xa000, self.k)?;

        for i in 0..N {
            let i_32 = u32::try_from(i)
                .expect("Cannot convert usize to u32");
            let msg: u32 = ((i_32+1) << 16) | (self.filter[i] as u32);
            //let msg: u32 = ((i_32+1) << 16) | 0xffff;
            xdma.write_reg(0x6000, msg)?;
        }
        Ok(())
    }
}

fn decode_hash(line: &[u8; 33]) -> std::io::Result<[u32; 4]> {
    if line[32] != 0x0a {
        return Err(std::io::Error::new(std::io::ErrorKind::Other,
            "Hash in file does not end with newline"));
    }

    let result = [0u32; 4];
    let mut words: [u8; 16] = unsafe { std::mem::transmute(result) };
    let mut z = 0;
    for i in (0..32).step_by(2) {
        let high = match line[i] {
            0x30..=0x39 => line[i] - 0x30, // 0-9
            0x41..=0x46 => line[i] - 0x41 + 10, // A-F
            0x61..=0x66 => line[i] - 0x61 + 10, // a-f
            _ => return Err(std::io::Error::new(
                std::io::ErrorKind::Other, "Hash in file is not in hex format"))
        };
        let low = match line[i+1] {
            0x30..=0x39 => line[i+1] - 0x30, // 0-9
            0x41..=0x46 => line[i+1] - 0x41 + 10, // A-F
            0x61..=0x66 => line[i+1] - 0x61 + 10, // a-f
            _ => return Err(std::io::Error::new(
                std::io::ErrorKind::Other, "Hash in file is not in hex format"))
        };

        words[z] = (high * 16) + low;
        z += 1;
    }

    let decoded: [u32; 4] = unsafe{std::mem::transmute(words)};
    return Ok(decoded);
}

fn decode_file(path: &std::path::Path) -> std::io::Result<(phf::Phf<[u32; 4]>, BloomFilter<FILTER_SIZE>, u64)> {
    // (1) read file and convert hashes to bytes
    let mut file = std::fs::File::open(path)?;
    let estimate = usize::try_from(std::fs::metadata(path)?.len() / 33)
        .expect("Cannot cast u64 to usize");
    let mut hashes = Vec::with_capacity(estimate);
    let mut buffer = [0u8; 33];
    loop {
        let bytes_read = (&mut file).take(33).read(&mut buffer)?;
        if bytes_read < 33 { break; }
        let hash = decode_hash(&buffer)?;
        hashes.push(hash);
    }
    let total_len = (&hashes).len();
    println!("Read {} hashes from file {}", total_len, path.display());

    let filter = BloomFilter::<FILTER_SIZE>::from_hashes(&hashes);

    // (2) create PHF from hashes in file
    let cfg = phf::Config{
        keys_per_bucket: 4,
        keys_per_bin: 1,
        load_factor: 0.8
    };
    let phf = phf::Phf::new(&cfg, hashes.into()).unwrap();
    println!("Initialized perfect hash function (load_factor={})",
        cfg.load_factor);

    // (3) generate bloom filter from hashes
    return Ok((phf, filter, u64::try_from(total_len).expect("Cannot cast usize to u64")))
}


fn main() -> std::io::Result<()> {
    

    let (phf, filter, total_hashes) = decode_file(std::path::Path::new("./hashes.txt"))?;
     println!("Bloom filter k value: {}", filter.k);
    // Setup ringbuffer between PCIE <-> ring threads
    let buffer = ring::Ringbuffer::<Beat, 8192>::new();
    let (mut writer, mut reader) = buffer.split();

    // Setup XDMA wrapper
    let dev = xdma::PCIDevice {
        domain_id: 0x0,
        bus_id: 0x4,
        device_id: 0x0,
        pf_id: 0x0,
        pci_vendor_id: 0x10ee,
        pci_device_id: 0x903f,
    };
    let xdma = xdma::XDMA::new(dev)?;

    // Program bloom filter
    println!("Writing bloom filter");
    filter.program(&xdma)?;

    let done_gen = Arc::new(AtomicBool::new(false));
    let done_consume = Arc::new(AtomicBool::new(false));
    let total_found = Arc::new(AtomicU64::new(0));
    let phf = Arc::new(phf);

    println!("Starting tasks");

    let do_dump = false;
    let rapl_start = read_rapl_energy().ok();
    let overall_start = Instant::now();

    thread::scope(|s| -> std::io::Result<()> {
        // Create scoped mutable references that can be moved into thread closures
        let writer_ref: &mut ring::Writer<Beat, 8192> = &mut writer;
        let reader_ref: &mut ring::Reader<Beat, 8192> = &mut reader;

        if do_dump {
            let done_pcie = done_gen.clone();
            let done_ring_in = done_gen.clone();

            // Move the refs into the closures
            let w = writer_ref;
            let r = reader_ref;

            let h_pcie = s.spawn(move || -> std::io::Result<()> {
                    pcie_thread(done_pcie, w, xdma)
            });

            let h_dump = s.spawn(move || -> std::io::Result<()> {
                dump_thread(done_ring_in, r, "dump.bin")
            });

            h_pcie.join().unwrap()?;
            h_dump.join().unwrap()?;
            return Ok(());
        }

        // Normal mode
        let (mut write_slots, read_slots): (Vec<_>, Vec<_>) = (0..HASH_THREADS)
            .map(|_| ring::Ringbuffer::<Beat, 64>::new())
            .map(|buf| buf.split())
            .unzip();

        // Spawn MD4 threads
        let mut md4_handles = Vec::with_capacity(HASH_THREADS);
        for (i, slot) in read_slots.into_iter().enumerate() {
            let done_md4 = done_consume.clone();
            let phf_md4 = phf.clone();
            let total_found_md4 = total_found.clone();
            md4_handles.push(s.spawn(move || {
                md4_thread::<SLOT_DEPTH, TRAIL_LEN>(
                    i, done_md4, slot, phf_md4, total_hashes, total_found_md4
                )
            }));
        }

        let done_pcie = done_gen.clone();
        let done_ring_in = done_gen.clone();
        let done_ring_out = done_consume.clone();

        // Move the refs into these closures
        let w = writer_ref;
        let r = reader_ref;

        let h_pcie = s.spawn(move || -> std::io::Result<()> {
                pcie_thread(done_pcie, w, xdma)
        });

        let h_ring = s.spawn(move || -> std::io::Result<()> {
            ring_thread(done_ring_in, done_ring_out, r, &mut write_slots)
        });

        // Join pipeline drivers first
        h_ring.join().unwrap()?;
        h_pcie.join().unwrap()?;

        // Join MD4 threads
        for h in md4_handles {
            h.join().unwrap();
        }

        Ok(())
    })?;

    // Summary
    let overall_elapsed = overall_start.elapsed();
    let final_found = total_found.load(Ordering::Relaxed);
    let rapl_end = read_rapl_energy().ok();

    println!("\n========================================");
    println!("        FINAL RESULTS SUMMARY");
    println!("========================================");
    println!(
        "Total runtime: {:.2?} ({:.3}s)",
        overall_elapsed,
        overall_elapsed.as_secs_f64()
    );
    println!("Target hashes: {}", total_hashes);
    println!("Hashes found: {}", final_found);

    match (rapl_start, rapl_end) {
        (Some(s), Some(e)) => {
            let secs = overall_elapsed.as_secs_f64().max(1e-9);

            let pkg_delta_uj = delta_uj(
                s.package_uj,
                e.package_uj,
                s.package_max_uj.max(e.package_max_uj),
            );
            let pkg_j = uj_to_j(pkg_delta_uj);
            let pkg_w = pkg_j / secs;

            println!("CPU Package Energy: {:.3} J ({:.3} Wh)", pkg_j, pkg_j / 3600.0);
            println!("CPU Average Power:  {:.3} W", pkg_w);

            if s.cores_uj > 0 && e.cores_uj > 0 {
                let cores_delta_uj =
                    delta_uj(s.cores_uj, e.cores_uj, s.cores_max_uj.max(e.cores_max_uj));
                let cores_j = uj_to_j(cores_delta_uj);
                println!(
                    "CPU Cores Energy:   {:.3} J (avg {:.3} W)",
                    cores_j,
                    cores_j / secs
                );
            }

            if s.dram_uj > 0 && e.dram_uj > 0 {
                let dram_delta_uj =
                    delta_uj(s.dram_uj, e.dram_uj, s.dram_max_uj.max(e.dram_max_uj));
                let dram_j = uj_to_j(dram_delta_uj);
                println!(
                    "DRAM Energy:        {:.3} J (avg {:.3} W)",
                    dram_j,
                    dram_j / secs
                );
            }
        }
        _ => {
            println!("Power: N/A (could not read RAPL; try sudo or ensure intel_rapl/intel-rapl is available)");
        }
    }

    println!("========================================\n");
    Ok(())
}


#[derive(Default, Debug, Copy, Clone)]
#[repr(C, packed(1))]
struct Beat {
    hash_mask: u32,
    prefix: u8,
    pw: [u8; 9],
    status: u16,
}
unsafe impl Send for Beat {}


fn pcie_thread<const N: usize>(
    done: Arc<AtomicBool>,
    writer: &mut ring::Writer<Beat, N>,
    xdma: xdma::XDMA,
) -> std::io::Result<()>
 {
    
    const QADDR: usize = 0xc0000000;
    let mut tmp: Box<[Beat]> = vec![Beat::default(); QDEPTH].into_boxed_slice();
    let mut pull_ptr = 0;

    // Start processing
    xdma.write_reg(0x4000, 1)?;
    println!("Started processing on FPGA");

    // Statistics
    let mut total_len: u64 = 0;
    let mut pulls: u64 = 0;
    let mut total_buf_len: u64 = 0;
    let mut total_read_len: u64 = 0;
    let mut buf_merges: u64 = 0;
    let mut empty_spins = 0u32; //added	


    // Read from FPGA queue to ring buffer
    loop {
        let push_ptr: usize = (xdma.read_reg(0x2000)?).try_into()
            .expect("Cannot convert u32 to usize");
        let data_len = (push_ptr.wrapping_sub(pull_ptr)) % QDEPTH;

        pulls += 1;

        if data_len == 0 {
            if done.load(Ordering::Relaxed) {
                break;
            }
            empty_spins += 1;
            if empty_spins < 10_000 {
                std::hint::spin_loop();
            } else {
                empty_spins = 0;
                std::thread::yield_now();
            }

            

            continue;
        }
        empty_spins = 0;

        // (1) Pull data
        let max_len = QDEPTH - pull_ptr;
        let end_len = data_len.clamp(0, max_len);

        loop {
            if let Err(_) = writer.write(data_len, |buf_back, buf_front| {
                let buf_back_len = (&buf_back).len();
                let buf_front_len = (&buf_front).len();
                total_buf_len += u64::try_from(buf_back_len + buf_front_len).expect("Cannot cast usize to u64");
                let mut do_merge = false;

                if end_len > 0 {
                    // (1a) Pull from the end of the hardware buffer
                    let buf: &mut [Beat] = if buf_back_len >= end_len {
                        unsafe { std::mem::transmute(&mut buf_back[0..end_len]) }
                    } else if buf_front_len < end_len {
                        do_merge = true;
                        unsafe { std::mem::transmute(&mut tmp[0..end_len]) }
                    } else {
                        unsafe { std::mem::transmute(&mut buf_front[0..end_len]) }
                    };

                    total_read_len += u64::try_from(buf.len()).expect("Cannot cast usize to u64");
                    xdma.read_dma(QADDR + (pull_ptr * size_of::<Beat>()), buf).unwrap();

                    total_len += u64::try_from(buf.len()).expect("Cannot cast usize to u64");
                    assert_eq!(buf.len(), end_len);
                }

                if end_len < data_len {
                    // (1b) Pull from the start of the hardware buffer
                    let buf: &mut [Beat] = if buf_back_len >= data_len {
                        unsafe { std::mem::transmute(&mut buf_back[end_len..data_len]) }
                    } else if buf_back_len != end_len {
                        unsafe { std::mem::transmute(&mut tmp[end_len..data_len]) }
                    } else {
                        unsafe { std::mem::transmute(&mut buf_front[0..(data_len - end_len)]) }
                    };

                    total_read_len += u64::try_from(buf.len()).expect("Cannot cast usize to u64");
                    xdma.read_dma(QADDR, buf).unwrap();

                    total_len += u64::try_from(buf.len()).expect("Cannot cast usize to u64");
                    assert_eq!(buf.len(), data_len - end_len);

                }

                // (2) Commit queue read to FPGA
                xdma.write_reg(0x0, push_ptr.try_into()
                    .expect("Cannot convert usize to u32")).unwrap();

                // (3) merge buffers if non-contigous
                if do_merge {
                    buf_merges += 1;
                    buf_back.copy_from_slice(&tmp[0..buf_back_len]);
                    buf_front.copy_from_slice(&tmp[buf_back_len..data_len]);
                }
            }) {
                continue;
            }
            break;
        }

        // Commit ring buffer
        writer.commit();
        pull_ptr = push_ptr;

       

        if done.load(Ordering::Relaxed) {
            break;
        }
    }

    let avg_use = total_len / pulls;
    println!("[XDMA] Final FPGA queue utilization pulls={} total_beats={} avg_beats={} avg_use={} total_cap={} total_read={} merges={}",
        pulls, total_len, avg_use, (avg_use as f64) / (QDEPTH as f64), total_buf_len, total_read_len, buf_merges);

    Ok(())
}


#[allow(dead_code)]
fn dump_thread<const N: usize> (done_in: Arc<AtomicBool>,
    reader: &mut ring::Reader<Beat, N>, filename: &str) -> std::io::Result<()> {
    let mut file = File::create(filename)?;
    let mut is_done = false;
    loop {
        loop {
            if is_done {break;}
            if let Err(_) = reader.read(|buf_back, buf_front| {
                let buf_back_bytes = unsafe {std::slice::from_raw_parts(
                    (buf_back as *const [Beat]) as *const u8, core::mem::size_of::<Beat>() * buf_back.len())};
                let buf_front_bytes = unsafe {std::slice::from_raw_parts(
                    (buf_front as *const [Beat]) as *const u8, core::mem::size_of::<Beat>() * buf_front.len())};
                let _ = file.write_all(buf_back_bytes);
                let _ = file.write_all(buf_front_bytes);

                for &e in buf_back {
                    if e.status != 0 {
                        is_done = true;
                        break;
                    }
                }
                for &e in buf_front {
                    if e.status != 0 {
                        is_done = true;
                        break;
                    }
                }
            }) {continue;}
            break;
        }
        reader.commit();

        if is_done {
            done_in.store(true, Ordering::Relaxed);
            break;
        }
    }
    Ok(())
}

fn ring_thread<const N: usize, const M: usize> (done_in: Arc<AtomicBool>, done_out: Arc<AtomicBool>,
    reader: &mut ring::Reader<Beat, N>, tx: &mut [ring::Writer<Beat, M>]) -> std::io::Result<()> {
    

    let start_time = Instant::now();
    let mut total_data = 0;

    let slots = tx.len();
    let mut cap_stats = vec![0u64; slots];
    let mut slot_stats = vec![0u64; slots];
    let mut slot = 0;

    loop {
        // (1) Read new data from FPGA
        let mut is_done = false;
        loop {
            if is_done { break; }
            if let Err(_) = reader.read(|buf_back, buf_front| {
                let buf_front_len = buf_front.len();
                let buf_back_len = buf_back.len();
                total_data += buf_back_len + buf_front_len;

                let mut pos = 0;
                while pos < buf_back_len {
                    let back_write_size = std::cmp::min(buf_back_len - pos, tx[slot].free());
                    let rem_buf_back = &buf_back[pos..(pos + back_write_size)];
                    if let Err(_) = tx[slot].write(back_write_size, |back, front| {
                        let rem_buf_back_len = rem_buf_back.len();
                        let back_back_cap = std::cmp::min(rem_buf_back_len, back.len());
                        let back_front_cap = std::cmp::min(rem_buf_back_len.saturating_sub(back_back_cap), front.len());

                        back[0..back_back_cap].copy_from_slice(&rem_buf_back[..back_back_cap]);
                        front[0..back_front_cap].copy_from_slice(&rem_buf_back[back_back_cap..]);

                        for &e in rem_buf_back {
                            if e.status != 0 {
                                is_done = true;
                            }
                        }

                        cap_stats[slot] += u64::try_from(back.len() + front.len()).expect("Cannot cast usize to u64");
                        slot_stats[slot] += u64::try_from(rem_buf_back_len).expect("Cannot cast usize to u64");
                        pos += back_write_size;
                    }) {}
                    tx[slot].commit();
                    slot = (slot + 1) % slots;
                }

                pos = 0;
                while pos < buf_front_len {
                    let front_write_size = std::cmp::min(buf_front_len - pos, tx[slot].free());
                    let rem_buf_front = &buf_front[pos..(pos + front_write_size)];
                    if let Err(_) = tx[slot].write(front_write_size, |back, front| {
                        let rem_buf_front_len = rem_buf_front.len();
                        let front_back_cap = std::cmp::min(rem_buf_front_len, back.len());
                        let front_front_cap = std::cmp::min(rem_buf_front_len.saturating_sub(front_back_cap), front.len());

                        back[0..front_back_cap].copy_from_slice(&rem_buf_front[..front_back_cap]);
                        front[0..front_front_cap].copy_from_slice(&rem_buf_front[front_back_cap..]);

                        for &e in rem_buf_front {
                            if e.status != 0 {
                                is_done = true;
                            }
                        }

                        cap_stats[slot] += u64::try_from(back.len() + front.len()).expect("Cannot cast usize to u64");
                        slot_stats[slot] += u64::try_from(rem_buf_front_len).expect("Cannot cast usize to u64");
                        pos += front_write_size;
                    }) {}
                    tx[slot].commit();
                    slot = (slot + 1) % slots;
                }

            }) { continue; }
            break;
        }

        // (3) Commit read data
        reader.commit();



        // (4) Terminate if trailing bit was set
        if is_done {
            done_in.store(true, Ordering::Relaxed);
            break;
        }

    }

    done_out.store(true, Ordering::Relaxed);
    Ok(())
}

fn md4_thread<const SUB_DEPTH: usize, const TRAIL_LEN: usize>
    (thread_id: usize, done: Arc<AtomicBool>, mut slot: ring::Reader<Beat, SUB_DEPTH>,
        phf: Arc<phf::Phf<[u32; 4]>>, total_hashes: u64, total_found: Arc<AtomicU64>) {
        
    let mut i: u64 = 0;
    let mut matches: u64 = 0;
    let mut beats: u64 = 0;
    
    // Track which hashes we've already found to avoid duplicates
    let mut found_hashes = std::collections::HashSet::new();

    let mut hasher = md4::new_sse2::<TRAIL_LEN>().unwrap();
    'outer: loop {
        // Process available data in slot
        'inner: loop {
            if let Err(_) = slot.read(|back, front| {
                beats += u64::try_from(back.len() + front.len())
                    .expect("Cannot cast usize to u64");
                for beat in back.into_iter().chain(front) {
                    if beat.status > 0 {
                        break;
                    }
                    // Unpack matches in HW pipelines
                    let pw = beat.pw[..TRAIL_LEN].try_into()
                        .expect("Cannot downcast array length");
                    hasher.submit(beat.hash_mask, beat.prefix, pw, |digest| {
                        i += 1;
                        if phf.has(&digest) {
                            // Check if we've already found this hash
                            if found_hashes.insert(digest) {
                                // This is a new hash - insert returns true if it wasn't present
                                let new_total = total_found.fetch_add(1, Ordering::Relaxed) + 1;
                                println!("[MD4] Found hash {:?} ({}/{})", digest, new_total, total_hashes);
                                matches += 1;
                            }
                            // else: duplicate - silently skip
                        }
                    });
                }
            }) {
                if done.load(Ordering::Relaxed) {
                    break 'outer;
                }
                continue 'inner;
            }
            break 'inner;
        }
        slot.commit();
    }

    slot.commit();

    hasher.flush(|digest| {
        if phf.has(&digest) {
            // Check if we've already found this hash
            if found_hashes.insert(digest) {
                let new_total = total_found.fetch_add(1, Ordering::Relaxed) + 1;
                println!("[MD4] Found hash {:?} ({}/{})", &digest, new_total, total_hashes);
                matches += 1;
            }
        }
        i += 1;
    });

    println!("[MD4] Thread {} processed {} candidates and {} matches in {} beats", thread_id, i, matches, beats);
}

