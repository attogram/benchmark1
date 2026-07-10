// Source: https://github.com/php/php-src/blob/master/ext/standard/password.c

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "argon2.h"

#define HASHLEN 32
#define SALTLEN 16

int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <password> <iterations>\\n", argv[0]);
        return 1;
    }

    char *pwd = argv[1];
    int iterations = atoi(argv[2]);

    uint8_t salt[SALTLEN];
    memset(salt, 0x00, SALTLEN); // For simplicity, using a fixed salt for the benchmark.

    uint32_t t_cost = 2; // time_cost
    uint32_t m_cost = 32768; // memory_cost in KiB
    uint32_t parallelism = 1; // threads

    char hash[HASHLEN];

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    for (int i = 0; i < iterations; i++) {
        argon2i_hash_raw(t_cost, m_cost, parallelism, pwd, strlen(pwd), salt, SALTLEN, hash, HASHLEN);
    }

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_spent = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1000000000.0;
    printf("%.12f\\n", time_spent);

    return 0;
}
