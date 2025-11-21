#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <openssl/sha.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <string> <iterations>\n", argv[0]);
        return 1;
    }

    char *string = argv[1];
    int iterations = atoi(argv[2]);

    unsigned char hash[SHA256_DIGEST_LENGTH];

    clock_t start = clock();

    for (int i = 0; i < iterations; i++) {
        SHA256((unsigned char*)string, strlen(string), hash);
    }

    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%f\n", time_spent);

    return 0;
}
