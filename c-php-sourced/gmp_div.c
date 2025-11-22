// C implementation to mirror the functionality of php/gmp_div.php
// Based on the existing C implementation in c-1/gmp_div.c for consistency.

#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <gmp.h>

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <num_a> <num_b> <iterations>\\n", argv[0]);
        return 1;
    }

    char *a_str = argv[1];
    char *b_str = argv[2];
    int iterations = atoi(argv[3]);

    mpz_t a, b, result;
    mpz_init_set_str(a, a_str, 10);
    mpz_init_set_str(b, b_str, 10);
    mpz_init(result);

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    for (int i = 0; i < iterations; i++) {
        mpz_div(result, a, b);
    }

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_spent = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1000000000.0;
    printf("%.12f\\n", time_spent);

    mpz_clear(a);
    mpz_clear(b);
    mpz_clear(result);

    return 0;
}
