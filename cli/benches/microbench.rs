use criterion::{criterion_group, criterion_main, Criterion, BenchmarkId};
use rand::{rngs::SmallRng, SeedableRng, RngCore};
use std::thread::available_parallelism;

fn do_hash_sse2(mask: u32, pws: &Box<[[u8; 5]]>) {
	let pw_len = pws.len();
	let mut hasher = fpgacrack::md4::new_sse2::<5>().unwrap();
	for i in 0..pw_len {
			hasher.submit(mask, 0u8, pws[i], |_digests| {});
	}
	hasher.flush(|_digests| {});
}

fn do_hash_avx2(mask: u32, pws: &Box<[[u8; 5]]>) {
	let pw_len = pws.len();
	let mut hasher = fpgacrack::md4::new_avx2::<5>().unwrap();
	for i in 0..pw_len {
			hasher.submit(mask, 0u8, pws[i], |_digests| {});
	}
	hasher.flush(|_digests| {});
}

fn do_hash_avx512(mask: u32, pws: &Box<[[u8; 5]]>) {
	let pw_len = pws.len();
	let mut hasher = fpgacrack::md4::new_avx512::<5>().unwrap();
	for i in 0..pw_len {
			hasher.submit(mask, 0u8, pws[i], |_digests| {});
	}
	hasher.flush(|_digests| {});
}

fn do_phf(c: &mut Criterion, samples: usize) {
	let rng = &mut SmallRng::from_os_rng();
	let hashes: Box<[[u8; 16]]> = (0..samples).map(|_| {
			let mut bytes = [0u8; 16];
			rng.fill_bytes(&mut bytes);
			bytes
		}).collect::<Vec<[u8; 16]>>().into_boxed_slice();

		let mut group = c.benchmark_group("phf");
		group.throughput(criterion::Throughput::Elements(samples as u64));
		group.bench_with_input(BenchmarkId::new("query", samples), &hashes, |b, hashes| {
			let clone = hashes.clone();
			let cfg = fpgacrack::phf::Config {keys_per_bucket: 4, keys_per_bin: 1, load_factor: 0.5};
			let phf = fpgacrack::phf::Phf::<[u8; 16]>::new(&cfg, clone).unwrap();
			b.iter(|| { for i in 0..samples {let _ = phf.query(&hashes[i]);} });
		});
		group.finish();
	}

fn phf_bench(c: &mut Criterion) {
	for sample_scale in 1..=10 {
		let samples = sample_scale * 10;
		do_phf(c, samples);
	}
	for sample_scale in 1..=10 {
		let samples = sample_scale * 100;
		do_phf(c, samples);
	}
	for sample_scale in 1..=10 {
		let samples = sample_scale * 1000;
		do_phf(c, samples);
	}
	for sample_scale in 1..=10 {
		let samples = sample_scale * 10000;
		do_phf(c, samples);
	}
	for sample_scale in 1..=10 {
		let samples = sample_scale * 1000000;
		do_phf(c, samples);
	}
}

/// md4_simd_bench measures expand and hash operations
fn md4_simd_bench(c: &mut Criterion) {
	let rng = &mut SmallRng::from_os_rng();

	const PW_LEN: usize = 5;
	const SAMPLES: usize = 100000;
	let bytes = u64::try_from(SAMPLES * PW_LEN).expect("Cannot cast usize to u64");
	let pws: Box<[[u8; PW_LEN]]> = (0..SAMPLES)
		.map(|_| {let mut bytes = [0u8; PW_LEN]; rng.fill_bytes(&mut bytes); bytes})
		.collect::<Vec<[u8; PW_LEN]>>().into_boxed_slice();

	let max_threads = u64::try_from(available_parallelism().unwrap().get())
		.expect("Cannot cast usize to u64");

	for bit_scale in 0..=2 {
		let bits_set = (bit_scale * 16).clamp(1, 32);
		for thread_count in 1..max_threads {
			let mask = (1u32 << bits_set) - 1;
			let mut group = c.benchmark_group(format!("md4/{thread_count}/{bits_set}"));
			group.throughput(criterion::Throughput::Bytes(u64::try_from(SAMPLES * 64).expect("Cannot cast usize to u64")
				* bits_set * thread_count));

			if fpgacrack::md4::supported_lane_count(4) {
				group.bench_with_input(BenchmarkId::new("sse2", SAMPLES), &pws, |b, pws| {
					b.iter(|| {
						let mut handles = vec![];
						for _ in 0..thread_count {
							let data = pws.clone();
							let handle = std::thread::spawn(move || {do_hash_sse2(mask, &data)});
							handles.push(handle);
						}
						for handle in handles {
							handle.join().unwrap();
						}
					});
				});
			}

			if fpgacrack::md4::supported_lane_count(8) {
				group.bench_with_input(BenchmarkId::new("avx2", SAMPLES), &pws, |b, pws| {
					b.iter(|| {
						let mut handles = vec![];
						for _ in 0..thread_count {
							let data = pws.clone();
							let handle = std::thread::spawn(move || {do_hash_avx2(mask, &data)});
							handles.push(handle);
						}
						for handle in handles {
							handle.join().unwrap();
						}
					});
				});
			}

			if fpgacrack::md4::supported_lane_count(16) {
				group.bench_with_input(BenchmarkId::new("avx512", SAMPLES), &pws, |b, pws| {
					b.iter(|| {
						let mut handles = vec![];
						for _ in 0..thread_count {
							let data = pws.clone();
							let handle = std::thread::spawn(move || {do_hash_avx512(mask, &data)});
							handles.push(handle);
						}
						for handle in handles {
							handle.join().unwrap();
						}
					});
				});
			}

			group.finish();
		}
	}
}

criterion_group!(benches, phf_bench, md4_simd_bench);
criterion_main!(benches);
