#include <stdio.h>

int main() {
    int i = 1000000;
    
    while (1) {
        printf("%d\n", i);
        i--;
        
        if (i == 0) {
            break;
        }
    }
}
