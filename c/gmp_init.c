#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>
#include <gmp.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <number> <iterations>\n", argv[0]);
        return 1;
    }

    char *number_str = argv[1];
    int iterations = atoi(argv[2]);

    mpz_t num, sum;
    mpz_init(sum);

    struct timeval start, end;
    gettimeofday(&start, NULL);

    for (int i = 0; i < iterations; i++) {
        mpz_init_set_str(num, number_str, 10);
        mpz_add(sum, sum, num);
        mpz_clear(num);
    }

    gettimeofday(&end, NULL);

    long seconds = (end.tv_sec - start.tv_sec);
    long micros = ((seconds * 1000000) + end.tv_usec) - (start.tv_usec);

    printf("%.12f\n", (double)micros / 1000000);

    mpz_clear(sum);

    return 0;
}
