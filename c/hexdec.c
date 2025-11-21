#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <hex_string> <iterations>\n", argv[0]);
        return 1;
    }

    char *hex_string = argv[1];
    int iterations = atoi(argv[2]);
    volatile long int dec_value;

    clock_t start = clock();

    for (int i = 0; i < iterations; i++) {
        dec_value = strtol(hex_string, NULL, 16);
    }

    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%f\n", time_spent);

    // The following line is to prevent the compiler from optimizing away the benchmarked code.
    if (dec_value == 123456789) {
        printf("Unlikely value\n");
    }

    return 0;
}
