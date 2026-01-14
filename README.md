# BF²
This repository includes the source code for the paper "BF²: A Bloom-Filtered Brute-Force Framework for High-Throughput Password Recovery".

`bf2_hw` includes a testbench to test the fpga implementation with a randomly generated bloom filter. Filter contents are read from "bloom_msgs.mem". 

Once FPGA is conencted (For our experiments: Nitefury II - XC7A200T-2FBG484E), with the current directory set to the same directory as the .xpr file, run the following commands in the tcl window: 
```tcl
source ./Scripts/add-flash-s25fl256s-0.tcl
source ./Scripts/program-flash.tcl
```

To build the project after changing parameters, run the following command in the tcl window: 
```tcl
source ./Scripts/build.tcl
```

#Host-side
## Running

The program currently reads `hashes.txt` for the matching logic.
Other configuration options like the PCIe device and the number
of threads + sizes are configured in `src/main.rs`.

```bash
cargo build --release
sudo ./target/release/fpgacrack
```


## Microbenchmarks

```bash
cargo bench
```


