#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <argon2.h>

#define SALT_LEN 16
#define HASH_LEN 32

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <password> <iterations>\n", argv[0]);
        return 1;
    }

    char *password = argv[1];
    int iterations = atoi(argv[2]);
    uint32_t t_cost = 3;
    uint32_t m_cost = 32768;
    uint32_t parallelism = 1;

    unsigned char salt[SALT_LEN];
    memset(salt, 0x00, SALT_LEN);
    volatile unsigned char hash[HASH_LEN];

    struct timeval start, end;
    gettimeofday(&start, NULL);

    for (int i = 0; i < iterations; i++) {
        argon2i_hash_raw(t_cost, m_cost, parallelism, password, strlen(password), salt, SALT_LEN, (unsigned char *)hash, HASH_LEN);
    }

    gettimeofday(&end, NULL);

    long seconds = (end.tv_sec - start.tv_sec);
    long micros = ((seconds * 1000000) + end.tv_usec) - (start.tv_usec);

    printf("%.12f\n", (double)micros / 1000000);

    return 0;
}
