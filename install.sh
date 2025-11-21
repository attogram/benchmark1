#!/bin/bash

set -e
set -o pipefail

echo "Updating package lists..."
sudo apt-get update

echo "Installing dependencies..."
sudo apt-get install -y gcc make php php-gmp libgmp-dev libargon2-dev libssl-dev bc

echo "Installation complete."
