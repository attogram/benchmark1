#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

void substring(const char* source, int start, int length, char* destination) {
    strncpy(destination, source + start, length);
    destination[length] = '\0';
}

int main(int argc, char *argv[]) {
    if (argc != 5) {
        fprintf(stderr, "Usage: %s <string> <start> <length> <iterations>\n", argv[0]);
        return 1;
    }

    char *string = argv[1];
    int start_pos = atoi(argv[2]);
    int length = atoi(argv[3]);
    int iterations = atoi(argv[4]);

    char dest[length + 1];

    clock_t start = clock();

    for (int i = 0; i < iterations; i++) {
        substring(string, start_pos, length, dest);
    }

    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%f\n", time_spent);

    return 0;
}
