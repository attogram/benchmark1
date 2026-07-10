# --- CUDA Configuration ---
# Check if nvcc is available
NVCC := $(shell command -v nvcc 2> /dev/null)
NVCCFLAGS=-O3 --std=c++11

# --- argon2-gpu Library ---
ARGON2_GPU_DIR=../argon2-gpu
ARGON2_GPU_INCLUDE_DIR=$(ARGON2_GPU_DIR)/include
ARGON2_GPU_LIB_DIR=$(ARGON2_GPU_DIR)
ARGON2_GPU_LIBS=-L$(ARGON2_GPU_LIB_DIR) -largon2-cuda -largon2-gpu-common

TARGETS =
ifdef NVCC
    TARGETS += password_hash_gpu
endif

# Default target: build all executables
all: $(TARGETS)

ifdef NVCC
password_hash_gpu: password_hash_gpu.cu
	$(NVCC) $(NVCCFLAGS) -I$(ARGON2_GPU_INCLUDE_DIR) -o $@ $< $(ARGON2_GPU_LIBS) -largon2
endif

# Target to clean up all compiled binaries
clean:
	rm -f $(TARGETS)
