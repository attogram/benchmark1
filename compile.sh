#!/bin/bash

set -e
set -o pipefail

echo "Compiling C benchmarks..."

# Navigate to the C directory
cd c

# Clean any old binaries
make clean

# Compile all benchmarks
make

echo "Compilation successful."
