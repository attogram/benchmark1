#!/bin/bash

set -e
set -o pipefail

# --- System Info ---
OS_INFO=$(uname -a)
CPU_INFO=$(lscpu | grep "Model name:" | sed 's/Model name:[ \t]*//')
MEM_INFO=$(free -h | grep "Mem:" | awk '{print $2}')
PHP_VERSION=$(php -v | head -n 1)
PHP_MODULES=$(php -m | tr '\n' ', ' | sed 's/,$//')
C_VERSION=$(gcc --version | head -n 1)
GLIBC_VERSION=$(getconf GNU_LIBC_VERSION)

# --- Configuration ---
ITERATIONS_CRYPTO=${1:-5000}
ITERATIONS_FAST=${2:-10000}
PASSWORD="correcthorsebatterystaple"
SHORT_STRING="hello world"
LONG_STRING="Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa."
SUBSTR_START=0
SUBSTR_LENGTH=8
GMP_A="1234567890123456789012345678901234567890"
GMP_B="9876543210987654321098765432109876543210"
HEX_STRING="a1b2c3d4e5f6a1b2c3d4e5f6"
SECONDS_TO_ADD=100000
SECONDS_TO_SUBTRACT=100000
RESULTS_FILE="results/benchmark_results.csv"

# --- Setup ---
mkdir -p results

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

    if [ $(echo "$PHP_TIME == 0" | bc) -eq 1 ]; then
        IMPROVEMENT="N/A"
    else
        IMPROVEMENT=$(echo "scale=2; (($PHP_TIME - $C_TIME) / $PHP_TIME) * 100" | bc)
    fi

    echo "$name,$iterations,$C_TIME,$PHP_TIME,$IMPROVEMENT,,," >> $RESULTS_FILE
    echo " Done."
}


# --- Run Benchmarks ---
echo "Running benchmarks..."
echo "Crypto Iterations: $ITERATIONS_CRYPTO"
echo "Fast Func Iterations: $ITERATIONS_FAST"
echo "Results will be saved to $RESULTS_FILE"
echo "function,iterations,c_time,php_time,c_vs_php_%,name,value," > $RESULTS_FILE

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

echo ",,,,,,, " >> $RESULTS_FILE
echo ",,,,,# Test Parameters,," >> $RESULTS_FILE
echo ",,,,,parameter,value," >> $RESULTS_FILE
echo ",,,,,iterations_crypto,$ITERATIONS_CRYPTO," >> $RESULTS_FILE
echo ",,,,,iterations_fast,$ITERATIONS_FAST," >> $RESULTS_FILE
echo ",,,,,password,$PASSWORD," >> $RESULTS_FILE
echo ",,,,,short_string,$SHORT_STRING," >> $RESULTS_FILE
echo ",,,,,long_string,${LONG_STRING:0:20}...," >> $RESULTS_FILE
echo ",,,,,substr_start,$SUBSTR_START," >> $RESULTS_FILE
echo ",,,,,substr_length,$SUBSTR_LENGTH," >> $RESULTS_FILE
echo ",,,,,gmp_a,$GMP_A," >> $RESULTS_FILE
echo ",,,,,gmp_b,$GMP_B," >> $RESULTS_FILE
echo ",,,,,hex_string,$HEX_STRING," >> $RESULTS_FILE
echo ",,,,,seconds_to_add,$SECONDS_TO_ADD," >> $RESULTS_FILE
echo ",,,,,seconds_to_subtract,$SECONDS_TO_SUBTRACT," >> $RESULTS_FILE

echo ",,,,,,, " >> $RESULTS_FILE
echo ",,,,,# System Specifications,," >> $RESULTS_FILE
echo ",,,,,spec,value," >> $RESULTS_FILE
echo ",,,,,os,\"$OS_INFO\"," >> $RESULTS_FILE
echo ",,,,,cpu,\"$CPU_INFO\"," >> $RESULTS_FILE
echo ",,,,,memory,$MEM_INFO," >> $RESULTS_FILE
echo ",,,,,c_compiler,\"$C_VERSION\"," >> $RESULTS_FILE
echo ",,,,,glibc,\"$GLIBC_VERSION\"," >> $RESULTS_FILE
echo ",,,,,php_version,\"$PHP_VERSION\"," >> $RESULTS_FILE
echo ",,,,,php_modules,\"$PHP_MODULES\"," >> $RESULTS_FILE

echo ""
echo "Benchmarking complete."
echo "Results:"
cat $RESULTS_FILE
