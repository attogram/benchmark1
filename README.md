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

2.  **Install C Dependencies:**
    This will install the GCC compiler, `make`, and the necessary development libraries for `libsodium`, `libgmp`, and `libssl`.
    ```bash
    sudo apt-get update
    sudo apt-get install -y gcc make libsodium-dev libgmp-dev libssl-dev
    ```

3.  **Install PHP Dependencies:**
    This will install the PHP command-line interface and the GMP extension required for the `gmp_*` benchmarks.
    ```bash
    sudo apt-get install -y php php-gmp
    ```

## How to Run the Benchmarks

The entire benchmarking process is automated with a single script.

1.  **Make the script executable:**
    (This only needs to be done once.)
    ```bash
    chmod +x benchmark.sh
    ```

2.  **Run the benchmark suite:**
    ```bash
    ./benchmark.sh [iterations]
    ```
    -   `[iterations]` is an optional argument that specifies the number of times each function should be executed in a loop.
    -   If not provided, it defaults to `10000`.

    **Example:**
    ```bash
    # Run with default iterations (10000)
    ./benchmark.sh

    # Run with 100,000 iterations
    ./benchmark.sh 100000
    ```

## How it Works

The `benchmark.sh` script performs the following actions:

1.  **Compiles C Code:** It navigates to the `c/` directory, removes any old binaries (`make clean`), and then compiles all the C source files using the optimized flags specified in the `Makefile` (`make`).
2.  **Executes Benchmarks:** For each function, it runs both the compiled C executable and the corresponding PHP script, passing the same set of parameters (input data and iterations).
3.  **Collects Results:** It captures the execution time (in seconds) from the output of each script.
4.  **Generates Report:** The results are saved in a CSV file at `results/benchmark_results.csv`. The script will also print the contents of this file to the console upon completion.

### A Note on `password_hash`

The PHP `password_hash` function with `PASSWORD_ARGON2I` allows a `time_cost` of 2. However, the `libsodium` library used for the C implementation requires a minimum `opslimit` (the equivalent of `time_cost`) of 3 for the Argon2i algorithm. To ensure the C code runs, it uses an `opslimit` of 3. This is a known difference between the two benchmark implementations.

## C Binaries

The repository does not include pre-compiled C binaries. You must compile them yourself by running the `benchmark.sh` script, which handles the compilation automatically. To compile the C code manually, you can run `make` inside the `c/` directory after installing the required dependencies.
