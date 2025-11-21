#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s <iterations>\n", argv[0]);
        return 1;
    }

    int iterations = atoi(argv[1]);
    volatile time_t current_time;

    clock_t start = clock();

    for (int i = 0; i < iterations; i++) {
        current_time = time(NULL);
    }

    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%f\n", time_spent);

    // The following line is to prevent the compiler from optimizing away the benchmarked code.
    if (current_time == 123456789) {
        printf("Unlikely value\n");
    }

    return 0;
}
