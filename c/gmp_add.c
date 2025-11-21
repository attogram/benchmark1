#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <gmp.h>

int main(int argc, char *argv[]) {
    if (argc != 4) {
        fprintf(stderr, "Usage: %s <num_a> <num_b> <iterations>\n", argv[0]);
        return 1;
    }

    char *a_str = argv[1];
    char *b_str = argv[2];
    int iterations = atoi(argv[3]);

    mpz_t a, b, result;
    mpz_init_set_str(a, a_str, 10);
    mpz_init_set_str(b, b_str, 10);
    mpz_init(result);

    clock_t start = clock();

    for (int i = 0; i < iterations; i++) {
        mpz_add(result, a, b);
    }

    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%f\n", time_spent);

    mpz_clear(a);
    mpz_clear(b);
    mpz_clear(result);

    return 0;
}
