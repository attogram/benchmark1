#!/bin/bash

set -e
set -o pipefail

echo "Updating package lists and installing dependencies..."

# Update package list
sudo apt-get update -y

# Install dependencies
sudo apt-get install -y \
    gcc \
    make \
    php \
    php-gmp \
    libgmp-dev \
    libargon2-dev \
    libssl-dev \
    bc \
    nvidia-cuda-toolkit \
    nvidia-utils-535

echo "Installation complete."
