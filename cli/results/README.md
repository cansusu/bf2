# Benchmark Results

The files in this folder contain benchmarking results.
Each file is named as `microbench-{benchmark}-{hw}-{index}.csv`.

## Benchmarks

- `phf`: Single-threaded lookup performance of the perfect hash function.
- `md4`: Multi-threaded SIMD performance of the MD4 re-calculation pipeline with varying bitmask utilization.

## Hardware Configurations

- `cube`: MSI AX211 NUC, Intel Core i7-1255U, 64G RAM
- `m2`: Apple Macbook with M2 chip, 16G RAM
