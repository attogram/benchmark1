CC=gcc
CFLAGS=-O3 -march=native -flto -Wall
LDLIBS=-lsodium -lcrypto -lgmp

# Get all .c files in the current directory
SOURCES=$(wildcard *.c)
# Create a list of executable names from the .c files
TARGETS=$(SOURCES:.c=)

# Default target: build all executables
all: $(TARGETS)

# Pattern rule to build an executable from a .c file
%: %.c
	$(CC) $(CFLAGS) -o $@ $< $(LDLIBS)

# Target to clean up all compiled binaries
clean:
	rm -f $(TARGETS)
