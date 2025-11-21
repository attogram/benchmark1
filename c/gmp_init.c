#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <gmp.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <number> <iterations>\n", argv[0]);
        return 1;
    }

    char *number_str = argv[1];
    int iterations = atoi(argv[2]);

    mpz_t num;

    clock_t start = clock();

    for (int i = 0; i < iterations; i++) {
        mpz_init_set_str(num, number_str, 10);
        mpz_clear(num);
    }

    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%f\n", time_spent);

    return 0;
}
