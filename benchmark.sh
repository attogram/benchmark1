#!/bin/bash

set -e
set -o pipefail

# --- Configuration ---
ITERATIONS=${1:-10000}
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

# --- Run Benchmarks ---
echo "Running benchmarks... (Iterations: $ITERATIONS)"
echo "Results will be saved to $RESULTS_FILE"
echo "function,c_time_s,php_time_s" > $RESULTS_FILE

# 1. password_hash
echo -n "Benchmarking password_hash..."
C_TIME=$(./c/password_hash "$PASSWORD" $ITERATIONS)
PHP_TIME=$(php php/password_hash.php "$PASSWORD" $ITERATIONS)
echo "password_hash,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 2. sha256
echo -n "Benchmarking sha256..."
C_TIME=$(./c/sha256 "$LONG_STRING" $ITERATIONS)
PHP_TIME=$(php php/sha256.php "$LONG_STRING" $ITERATIONS)
echo "sha256,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 3. substr
echo -n "Benchmarking substr..."
C_TIME=$(./c/substr "$LONG_STRING" $SUBSTR_START $SUBSTR_LENGTH $ITERATIONS)
PHP_TIME=$(php php/substr.php "$LONG_STRING" $SUBSTR_START $SUBSTR_LENGTH $ITERATIONS)
echo "substr,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 4. gmp_init
echo -n "Benchmarking gmp_init..."
C_TIME=$(./c/gmp_init "$GMP_A" $ITERATIONS)
PHP_TIME=$(php php/gmp_init.php "$GMP_A" $ITERATIONS)
echo "gmp_init,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 5. gmp_mul
echo -n "Benchmarking gmp_mul..."
C_TIME=$(./c/gmp_mul "$GMP_A" "$GMP_B" $ITERATIONS)
PHP_TIME=$(php php/gmp_mul.php "$GMP_A" "$GMP_B" $ITERATIONS)
echo "gmp_mul,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 6. gmp_add
echo -n "Benchmarking gmp_add..."
C_TIME=$(./c/gmp_add "$GMP_A" "$GMP_B" $ITERATIONS)
PHP_TIME=$(php php/gmp_add.php "$GMP_A" "$GMP_B" $ITERATIONS)
echo "gmp_add,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 7. gmp_div
echo -n "Benchmarking gmp_div..."
C_TIME=$(./c/gmp_div "$GMP_A" "$GMP_B" $ITERATIONS)
PHP_TIME=$(php php/gmp_div.php "$GMP_A" "$GMP_B" $ITERATIONS)
echo "gmp_div,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 8. hexdec
echo -n "Benchmarking hexdec..."
C_TIME=$(./c/hexdec "$HEX_STRING" $ITERATIONS)
PHP_TIME=$(php php/hexdec.php "$HEX_STRING" $ITERATIONS)
echo "hexdec,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 9. time
echo -n "Benchmarking time..."
C_TIME=$(./c/get_time $ITERATIONS)
PHP_TIME=$(php php/get_time.php $ITERATIONS)
echo "time,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 10. date_math_add
echo -n "Benchmarking date_math_add..."
C_TIME=$(./c/date_math_add $SECONDS_TO_ADD $ITERATIONS)
PHP_TIME=$(php php/date_math_add.php $SECONDS_TO_ADD $ITERATIONS)
echo "date_math_add,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 11. date_math_subtract
echo -n "Benchmarking date_math_subtract..."
C_TIME=$(./c/date_math_subtract $SECONDS_TO_SUBTRACT $ITERATIONS)
PHP_TIME=$(php php/date_math_subtract.php $SECONDS_TO_SUBTRACT $ITERATIONS)
echo "date_math_subtract,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

# 12. microtime
echo -n "Benchmarking microtime..."
C_TIME=$(./c/microtime $ITERATIONS)
PHP_TIME=$(php php/microtime.php $ITERATIONS)
echo "microtime,$C_TIME,$PHP_TIME" >> $RESULTS_FILE
echo " Done."

echo ""
echo "Benchmarking complete."
echo "Results:"
cat $RESULTS_FILE
