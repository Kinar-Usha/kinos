#include "../drivers/display.h"

void main() {
    clear_screen();
    while(1){
        print_string("1");
        print_nl();
        print_string("12");
        print_nl();
    }
}
