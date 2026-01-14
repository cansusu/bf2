# fpgacrack

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