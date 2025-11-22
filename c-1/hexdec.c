#include <stdio.h>
#include <stdlib.h>
#include <sys/time.h>

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <hex_string> <iterations>\n", argv[0]);
        return 1;
    }

    char *hex_string = argv[1];
    int iterations = atoi(argv[2]);

    struct timeval start, end;
    gettimeofday(&start, NULL);

    for (int i = 0; i < iterations; i++) {
        strtol(hex_string, NULL, 16);
    }

    gettimeofday(&end, NULL);

    long seconds = (end.tv_sec - start.tv_sec);
    long micros = ((seconds * 1000000) + end.tv_usec) - (start.tv_usec);

    printf("%.12f\n", (double)micros / 1000000);

    return 0;
}
