#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <sodium.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <password> <iterations>\n", argv[0]);
        return 1;
    }

    char *password = argv[1];
    int iterations = atoi(argv[2]);

    if (sodium_init() < 0) {
        fprintf(stderr, "Failed to initialize libsodium\n");
        return 1;
    }

    clock_t start = clock();

    unsigned long long opslimit = 3;
    size_t memlimit = 32768 * 1024;

    for (int i = 0; i < iterations; i++) {
        char hashed_password[crypto_pwhash_STRBYTES];
        if (crypto_pwhash_str_alg(hashed_password, password, strlen(password),
                                  opslimit, memlimit, crypto_pwhash_ALG_ARGON2I13) != 0) {
            fprintf(stderr, "Failed to hash password\n");
            return 1;
        }
    }

    clock_t end = clock();
    double time_spent = (double)(end - start) / CLOCKS_PER_SEC;
    printf("%f\n", time_spent);

    return 0;
}
