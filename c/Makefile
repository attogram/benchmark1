CC=gcc
CFLAGS=-O3 -march=native -flto -Wall

# --- CUDA Configuration ---
# Check if nvcc is available
NVCC := $(shell command -v nvcc 2> /dev/null)
NVCCFLAGS=-O3 -gencode arch=compute_75,code=sm_75 --std=c++11

# --- argon2-gpu Library ---
ARGON2_GPU_DIR=../argon2-gpu
ARGON2_GPU_INCLUDE_DIR=$(ARGON2_GPU_DIR)/include
ARGON2_GPU_LIB_DIR=$(ARGON2_GPU_DIR)
ARGON2_GPU_LIBS=-L$(ARGON2_GPU_LIB_DIR) -largon2-cuda -largon2-gpu-common

# Get all .c files in the current directory
SOURCES=$(wildcard *.c)
# Create a list of executable names from the .c files
TARGETS_C=$(SOURCES:.c=)

TARGETS = $(TARGETS_C)
ifdef NVCC
    TARGETS += password_hash_gpu
endif

# Default target: build all executables
all: $(TARGETS)

# General rule for programs with no special libs
%: %.c
	$(CC) $(CFLAGS) -o $@ $<

# Specific rules for programs with special libs
password_hash: password_hash.c
	$(CC) $(CFLAGS) -o $@ $< -largon2

ifdef NVCC
password_hash_gpu: password_hash_gpu.cu
	$(NVCC) $(NVCCFLAGS) -I$(ARGON2_GPU_INCLUDE_DIR) -o $@ $< $(ARGON2_GPU_LIBS) -largon2
endif

sha256: sha256.c
	$(CC) $(CFLAGS) -o $@ $< -lcrypto

gmp_init: gmp_init.c
	$(CC) $(CFLAGS) -o $@ $< -lgmp

gmp_mul: gmp_mul.c
	$(CC) $(CFLAGS) -o $@ $< -lgmp

gmp_add: gmp_add.c
	$(CC) $(CFLAGS) -o $@ $< -lgmp

gmp_div: gmp_div.c
	$(CC) $(CFLAGS) -o $@ $< -lgmp

# Target to clean up all compiled binaries
clean:
	rm -f $(TARGETS)
