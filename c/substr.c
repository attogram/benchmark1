#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/time.h>

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
    volatile int total_length = 0;

    struct timeval start, end;
    gettimeofday(&start, NULL);

    for (int i = 0; i < iterations; i++) {
        substring(string, start_pos, length, dest);
        total_length += strlen(dest);
    }

    gettimeofday(&end, NULL);

    long seconds = (end.tv_sec - start.tv_sec);
    long micros = ((seconds * 1000000) + end.tv_usec) - (start.tv_usec);

    printf("%.12f\n", (double)micros / 1000000);

    return 0;
}
