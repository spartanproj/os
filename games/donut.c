/*
    This file is part of BlueberryOS
    Written by: werdl
    Target: x86 32bit
    Info: github.com/spartanproj/os
*/
#include <stdio.h>
#include <math.h>
#include <stdlib.h>
#include <string.h>

int main() {
    int A = 0;
    int B = 0;
    int width = 80;
    int height = 24;
    while (1) {
        char output[height][width];
        memset(output, ' ', sizeof(output));
        double cos_A = cos(A);
        double sin_B = sin(B);
        double sin_A = sin(A);
        double cos_B = cos(B);
        for (int theta = 0; theta < 628; theta += 2) {
            double costheta = cos(theta / 100.0);
            double sintheta = sin(theta / 100.0);
            for (int phi = 0; phi < 628; phi += 2) {
                double cosphi = cos(phi / 100.0);
                double sinphi = sin(phi / 100.0);
                double circlex = costheta;
                double circley = 2 + sintheta * cosphi;
                double circlez = 2 + sintheta * sinphi;
                circlex = circlex * cos_B - circlez * sin_A * sin_B;
                circley = circley * cos_A - circlex * sin_A * sin_B - circlez * cos_A * sin_B;
                circlez = sin_B * circlex + cos_A * sin_A * sin_B * circley + cos_B * circlez - sin_A * sin_B * circlex * circley;
                circlex = (int)(width / 2 + circlex * width / 8);
                circley = (int)(height / 2 - circley * height / 8);
                if (0 <= circlex && circlex < width && 0 <= circley && circley < height) {
                    int luminance_index = (phi + theta) % 2;
                    output[circley][circlex] = ".,-~:;=!*#$@"[luminance_index];
                }
            }
        }
        for (int i = 0; i < height; i++) {
            for (int j = 0; j < width; j++) {
                putchar(output[i][j]);
            }
            putchar('\n');
        }
        A += 1;
        B += 2;
        usleep(100000);
        system("clear");
    }
    return 0;
}

/*3D-spinning-donut
