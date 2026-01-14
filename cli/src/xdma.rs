// This module abstracts communication via XDMA
use std::fs::{File, OpenOptions};
use std::io::{Result, Read};
use std::os::unix::fs::FileExt;
//use std::os::fd::AsRawFd;

pub struct PCIDevice {
    pub domain_id: u16,
    pub bus_id: u8,
    pub device_id: u8,
    pub pf_id: u8,
    pub pci_vendor_id: u16,
    pub pci_device_id: u16,
}

impl PCIDevice {
    pub fn to_sysfs_name(&self) -> String {
        format!("{:04x}:{:02x}:{:02x}.{}",
            self.domain_id, self.bus_id, self.device_id, self.pf_id)
    }
}

pub struct XDMA {
    pub bar0: File,
    pub dma_read: File,
    //dma_write: File,
}

impl XDMA {
    pub fn new(dev: PCIDevice) -> Result<Self> {
        let path = format!("/sys/bus/pci/devices/{}", dev.to_sysfs_name());

        println!("Checking for vendor file {}/vendor", path);
        Self::check_sysfs_file(format!("{}/vendor", path), dev.pci_vendor_id)?;
        println!("Checking for device file");
        Self::check_sysfs_file(format!("{}/device", path), dev.pci_device_id)?;
        println!("Checking for xdma file");
        let xdma_id = Self::find_xdma_id(format!("{}/xdma", path))?;

        println!("Opening paths");
        let bar0_path = format!("/dev/xdma{}_user", xdma_id);
        let dma_rd_path = format!("/dev/xdma{}_c2h_0", xdma_id);
        //let dma_wr_path = format!("/dev/xdma{}_h2c_0", xdma_id);

        return Ok(XDMA{
            bar0: OpenOptions::new().read(true).write(true).open(bar0_path)?,
            dma_read: OpenOptions::new().read(true).open(dma_rd_path)?,
            //dma_write: OpenOptions::new().write(true).open(dma_wr_path)?,
        })
    }

    fn check_sysfs_file(path: String, expected: u16) -> Result<bool> {
        let mut file = OpenOptions::new().read(true).open(path)?;
        let mut data = String::new();
        file.read_to_string(&mut data)?;
        let trimmed = data.trim().trim_start_matches("0x");
        let value = u16::from_str_radix(trimmed, 16)
            .expect("Failed to parse data as u16");
        Ok(value == expected)
    }

    fn find_xdma_id(path: String) -> Result<i32> {
        for entry in std::fs::read_dir(path)? {
            let entry = entry?;
            if let Some(name) = entry.file_name().to_str() {
                if name.starts_with("xdma") && name.ends_with("_h2c_0") {
                    let digits: String = name.chars().skip(4)
                        .take_while(|c| c.is_ascii_digit())
                        .collect();
                    if !digits.is_empty() {
                        return Ok(digits.parse::<i32>().ok()
                            .expect("Could not parse number"))
                    }
                }
            }
        }

        return Err(std::io::Error::other("No XDMA ID found"));
    }

    #[inline]
    pub fn read_reg(&self, addr: u64) -> Result<u32> {
        let mut value: u32 = 0;
        let ptr: &mut [u8] = unsafe {
            std::slice::from_raw_parts_mut(&mut value as *mut u32 as *mut u8,
                std::mem::size_of::<u32>())
        };
        if self.bar0.read_at(ptr, addr)? != std::mem::size_of::<u32>() {
            return Err(std::io::Error::other("Read too few bytes"));
        }
        Ok(value)
    }

    #[inline]
    pub fn write_reg(&self, addr: u64, data: u32) -> Result<()> {
        let raw: [u8; 4] = u32::to_le_bytes(data);
        if self.bar0.write_at(&raw, addr)? != std::mem::size_of::<u32>() {
            return Err(std::io::Error::other("Wrote too few bytes"));
        }
        Ok(())
    }

    #[inline]
    pub fn read_dma<T>(&self, addr: usize, data: &mut [T]) -> Result<()> {
        let bytes: &mut [u8] = unsafe { std::slice::from_raw_parts_mut(
            data.as_mut_ptr() as *mut u8, data.len() * size_of::<T>()) };

        let addr = <usize as TryInto<u64>>::try_into(addr)
            .expect("Cannot convert usize to u64");
        if self.dma_read.read_at(bytes, addr)? != bytes.len().into() {
            return Err(std::io::Error::other("Read too few DMA bytes"));
        }
        Ok(())
    }

    /*#[inline]
    pub fn read_dma_uring(&self, addr: usize, data: &mut [u8])
        -> io_uring::opcode::Read {
        return io_uring::opcode::Read::new(
            io_uring::types::Fd(self.dma_read.as_raw_fd()),
            data.as_mut_ptr(),
            data.len() as u32
        ).offset(<usize as TryInto<u64>>::try_into(addr)
            .expect("Cannot convert usize to u64"))
    }*/

    /*#[inline]
    pub fn write_dma(&self, addr: u64, data: &[u8]) -> Result<()> {
        if self.dma_write.write_at(data, addr)? != data.len().into() {
            return Err(std::io::Error::other("Wrote too few DMA bytes"));
        }
        Ok(())
    }*/
}
