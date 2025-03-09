#include <stdio.h>

// Function using pass by reference
int increment(int num) {  // num= &x
    num++;  // Change affects the original variable
    printf("Inside function: num = %d\n", num);
    return num;
}

int main() {
    int x = 5;
    printf("Before function call: x = %d\n", x);
    printf("%p\n",&x);
    x=increment(x);  // Pass address of x : &x
    // x=x+1;
    printf("After function call: x = %d\n", x);  // x is changed
    return 0;
}
