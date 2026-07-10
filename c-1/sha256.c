#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>
#include <openssl/evp.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <string> <iterations>\n", argv[0]);
        return 1;
    }

    char *string = argv[1];
    int iterations = atoi(argv[2]);
    size_t string_len = strlen(string);
    volatile unsigned char hash[EVP_MAX_MD_SIZE];
    unsigned int hash_len;

    EVP_MD_CTX *mdctx;
    const EVP_MD *md;

    md = EVP_sha256();
    mdctx = EVP_MD_CTX_new();

    struct timeval start, end;
    gettimeofday(&start, NULL);

    for (int i = 0; i < iterations; i++) {
        EVP_DigestInit_ex(mdctx, md, NULL);
        EVP_DigestUpdate(mdctx, string, string_len);
        EVP_DigestFinal_ex(mdctx, (unsigned char *)hash, &hash_len);
    }

    gettimeofday(&end, NULL);
    EVP_MD_CTX_free(mdctx);

    long seconds = (end.tv_sec - start.tv_sec);
    long micros = ((seconds * 1000000) + end.tv_usec) - (start.tv_usec);

    printf("%.12f\n", (double)micros / 1000000);

    return 0;
}
