#!/bin/bash

set -e
set -o pipefail

echo "Compiling C benchmarks..."
(cd c && make clean && make)
if [ $? -ne 0 ]; then
    echo "C compilation failed. Aborting."
    exit 1
fi
echo "Compilation successful."
echo ""
