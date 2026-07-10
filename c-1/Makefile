CC=gcc
CFLAGS=-O3 -march=native -flto -Wall

# Get all .c files in the current directory
SOURCES=$(wildcard *.c)
# Create a list of executable names from the .c files
TARGETS=$(SOURCES:.c=)

# Default target: build all executables
all: $(TARGETS)

# General rule for programs with no special libs
%: %.c
	$(CC) $(CFLAGS) -o $@ $<

# Specific rules for programs with special libs
password_hash: password_hash.c
	$(CC) $(CFLAGS) -o $@ $< -largon2

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
