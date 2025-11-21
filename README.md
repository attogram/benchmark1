# PHP vs. C Benchmarking System

This project provides a simple framework for benchmarking the performance of various functions in PHP against their equivalents in C.

## Benchmarked Functions

The following functions are included in this benchmark suite:

- `password_hash()` (using Argon2i)
- `hash('sha256', ...)`
- `substr()`
- `gmp_init()`
- `gmp_mul()`
- `gmp_add()`
- `gmp_div()`
- `hexdec()`
- `time()`
- Date Math: Addition
- Date Math: Subtraction
- `microtime(true)`

## Requirements

- Ubuntu 22.04 (or a compatible Debian-based distribution)
- `git`

## Setup and Installation

1.  **Clone the repository:**
    ```bash
    git clone <repository-url>
    cd <repository-directory>
    ```

2.  **Run the installer:**
    The `install.sh` script will update your package manager and install all the required dependencies (`gcc`, `make`, `php`, `php-gmp`, `libgmp-dev`, `libargon2-dev`, `libssl-dev`, and `bc`).
    ```bash
    ./install.sh
    ```

## How to Run the Benchmarks

The benchmarking process is broken into two main scripts: `compile.sh` and `benchmark.sh`.

1.  **Make the scripts executable:**
    (This only needs to be done once.)
    ```bash
    chmod +x compile.sh
    chmod +x benchmark.sh
    ```

2.  **Compile the C code:**
    This script navigates to the `c/` directory, cleans any old binaries, and compiles all the C source files using the optimized flags specified in the `Makefile`.
    ```bash
    ./compile.sh
    ```

3.  **Run the benchmark suite:**
    ```bash
    ./benchmark.sh [crypto_iterations] [fast_func_iterations]
    ```
    -   `[crypto_iterations]` is an optional argument for the number of iterations for slow cryptographic functions (e.g., `password_hash`). Defaults to `100`.
    -   `[fast_func_iterations]` is an optional argument for the number of iterations for all other, faster functions. Defaults to `100000`.

    **Example:**
    ```bash
    # Run with default iterations
    ./benchmark.sh

    # Run with 10 crypto iterations and 1,000,000 fast function iterations
    ./benchmark.sh 10 1000000
    ```

## How it Works

The `benchmark.sh` script performs the following actions:

1.  **Executes Benchmarks:** For each function, it runs both the compiled C executable and the corresponding PHP script, passing the same set of parameters (input data and iterations).
2.  **Collects Results:** It captures the execution time (in seconds) from the output of each script.
3.  **Generates Report:** The results are saved in a CSV file at `results/benchmark_results.csv`. The script will also print the contents of this file to the console upon completion.

### A Note on `password_hash`

To ensure a true "apples-to-apples" comparison, both the PHP and C implementations of the `password_hash` benchmark use the exact same parameters for the Argon2i algorithm:
- **Memory Cost:** 32768 KB
- **Time Cost:** 2
- **Threads:** 1

This is achieved by using the `libargon2` reference implementation in the C code, which is the same library used internally by PHP.

## C Binaries

You can compile the C binaries at any time by running the `./compile.sh` script or by running `make` inside the `c/` directory. The compiled binaries are committed to the repository.
