#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <seconds_to_subtract> <iterations>\n", argv[0]);
        return 1;
    }

    int seconds_to_subtract = atoi(argv[1]);
    int iterations = atoi(argv[2]);

    clock_t start = clock();

    for (int i = 0; i < iterations; i++) {
        time_t current_time = time(NULL);
        current_time -= seconds_to_subtract;
    }

    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%f\n", time_spent);

    return 0;
}
