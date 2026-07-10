#include <iostream>
#include <vector>
#include <chrono>

#include "argon2-cuda/globalcontext.h"
#include "argon2-cuda/device.h"
#include "argon2-cuda/programcontext.h"
#include "argon2-cuda/processingunit.h"
#include "argon2-gpu-common/argon2params.h"

int main(int argc, char *argv[]) {
    if (argc != 3) {
        fprintf(stderr, "Usage: %s <password> <iterations>\n", argv[0]);
        return 1;
    }

    char *password = argv[1];
    int iterations = atoi(argv[2]);

    try {
        argon2::cuda::GlobalContext global;
        auto &devices = global.getAllDevices();

        if (devices.empty()) {
            fprintf(stderr, "No CUDA-capable device found.\n");
            return 100;
        }

        auto &device = devices[0];
        argon2::cuda::ProgramContext pc(&global, { device },
                                        argon2::ARGON2_I,
                                        argon2::ARGON2_VERSION_13);

        argon2::Argon2Params params(32, (unsigned char *)password, strlen(password), NULL, 0, NULL, 0, 2, 32768, 1);
        argon2::cuda::ProcessingUnit unit(&pc, &params, &device, iterations, true, false);

        auto start_time = std::chrono::high_resolution_clock::now();
        unit.beginProcessing();
        unit.endProcessing();
        auto end_time = std::chrono::high_resolution_clock::now();
        auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(end_time - start_time);

        printf("%.12f\n", duration.count() / 1e9);

    } catch (const std::exception &ex) {
        fprintf(stderr, "Error: %s\n", ex.what());
        return 1;
    }

    return 0;
}
