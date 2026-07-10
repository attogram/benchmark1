// Implementation based on OpenSSL's libcrypto, mirroring the original c/sha256.c test.
// Source for PHP's hash function is complex to isolate, so this provides a standard C equivalent.

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <openssl/sha.h>

int main(int argc, char **argv) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <string> <iterations>\\n", argv[0]);
        return 1;
    }

    char *string = argv[1];
    int iterations = atoi(argv[2]);
    unsigned char hash[SHA256_DIGEST_LENGTH];

    struct timespec start, end;
    clock_gettime(CLOCK_MONOTONIC, &start);

    for (int i = 0; i < iterations; i++) {
        SHA256((unsigned char*)string, strlen(string), hash);
    }

    clock_gettime(CLOCK_MONOTONIC, &end);

    double time_spent = (end.tv_sec - start.tv_sec) + (end.tv_nsec - start.tv_nsec) / 1000000000.0;
    printf("%.12f\\n", time_spent);

    return 0;
}
