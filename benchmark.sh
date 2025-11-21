#!/bin/bash

set -e
set -o pipefail

# --- Configuration ---
ITERATIONS_CRYPTO=${1:-100}
ITERATIONS_FAST=${2:-100000}
PASSWORD="correcthorsebatterystaple"
SHORT_STRING="hello world"
LONG_STRING=$(head -c 1024 /dev/urandom | base64)
SUBSTR_START=6
SUBSTR_LENGTH=5
GMP_A="1234567890123456789012345678901234567890"
GMP_B="9876543210987654321098765432109876543210"
HEX_STRING="a1b2c3d4e5f6a1b2c3d4e5f6"
SECONDS_TO_ADD=86400
SECONDS_TO_SUBTRACT=3600
RESULTS_FILE="results/benchmark_results.csv"

# --- Setup ---
mkdir -p results

# --- Compile C code ---
echo "Compiling C benchmarks..."
(cd c && make clean && make)
if [ $? -ne 0 ]; then
    echo "C compilation failed. Aborting."
    exit 1
fi
echo "Compilation successful."
echo ""

# --- Helper Function ---
run_benchmark() {
    local name=$1
    shift
    local iterations=$1
    shift
    local c_args=("$@")
    local php_args=("$@")

    echo -n "Benchmarking $name..."
    C_TIME=$(./c/$name "${c_args[@]}" $iterations)
    PHP_TIME=$(php php/$name.php "${php_args[@]}" $iterations)
    echo "$name,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
    echo " Done."
}


# --- Run Benchmarks ---
echo "Running benchmarks..."
echo "Crypto Iterations: $ITERATIONS_CRYPTO"
echo "Fast Func Iterations: $ITERATIONS_FAST"
echo "Results will be saved to $RESULTS_FILE"
echo "function,c_time_s,php_time_s" > $RESULTS_FILE

run_benchmark "password_hash" $ITERATIONS_CRYPTO "$PASSWORD"
run_benchmark "sha256" $ITERATIONS_FAST "$LONG_STRING"
run_benchmark "substr" $ITERATIONS_FAST "$LONG_STRING" $SUBSTR_START $SUBSTR_LENGTH
run_benchmark "gmp_init" $ITERATIONS_FAST "$GMP_A"
run_benchmark "gmp_mul" $ITERATIONS_FAST "$GMP_A" "$GMP_B"
run_benchmark "gmp_add" $ITERATIONS_FAST "$GMP_A" "$GMP_B"
run_benchmark "gmp_div" $ITERATIONS_FAST "$GMP_A" "$GMP_B"
run_benchmark "hexdec" $ITERATIONS_FAST "$HEX_STRING"
run_benchmark "get_time" $ITERATIONS_FAST
run_benchmark "date_math_add" $ITERATIONS_FAST $SECONDS_TO_ADD
run_benchmark "date_math_subtract" $ITERATIONS_FAST $SECONDS_TO_SUBTRACT
run_benchmark "microtime" $ITERATIONS_FAST

echo ""
echo "Benchmarking complete."
echo "Results:"
cat $RESULTS_FILE
