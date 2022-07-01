#include "../drivers/display.h"
#include "../cpu/idt.h"
#include "../cpu/isr.h"
#include "../drivers/keyboard.h"
#include "util.h"
#include "mem.h"

// int *ptr = NULL_POINTER;

void* allocate(int n){

    int *ptr = (int *) mem_alloc(n * sizeof(int));
    if (ptr == NULL_POINTER) {
        print_string("Memory not allocated.\n");
    } else {
            for (int i = 0; i < n; ++i) {
           ptr[i] = i + 1;
        }
        print_string("Contents of memory\n");

        for (int i = 0; i < n; ++i) {
           char str[256];
           itoa_wannabe(ptr[i], str);
           print_string(str);
           print_string(" ");
        }
       print_nl();
    }
    return ptr;
} 
void start_kernel() {
    clear_screen();
    print_string("Installing interrupt service routines (ISRs).\n");
    isr_install();

    print_string("Enabling external interrupts.\n");
    asm volatile("sti");

    print_string("Initializing keyboard (IRQ 1).\n");
    init_keyboard();
    print_string("Initializing dynamic memory.\n");
    init_dynamic_mem();
    print_dynamic_node_size();
    print_dynamic_mem();
    print_nl();
    int *ptr1 = allocate(10);
    print_string("int *ptr1 = allocate(10)\n");
    print_dynamic_mem();
    print_nl();
    print_string("*ptr2 allocating (15)\n");
    int *ptr2 = allocate(15);
    print_dynamic_mem();
    print_nl();
    mem_free(ptr2);
    print_string("Freeing memory - ptr2\n");
    print_dynamic_mem();
    print_nl();
    mem_free(ptr1);
    print_string("Freeing memory - ptr1\n");
    print_dynamic_mem();
    print_nl();
    print_string("> ");


}
void execute_command(char *input) {
    if (compare_string(input, "EXIT") == 0) {
        print_string("Stopping the CPU. Bye!\n");
        asm volatile("hlt");
    }
    // else if(compare_string(input, "ALLOC") == 0){
    //     print_string("allocating memory");
    //     ptr = allocate(5);
    //     print_string("int *ptr = allocate(5)\n");
    //     print_dynamic_mem();
    //     print_nl();
    // }
    // else if (compare_string(input,"FREE") == 0)
    // {
    //     mem_free(ptr);
    //     print_string("mem_free(ptr1)\n");
    //     print_dynamic_mem();
    //     print_nl();
    // }
    else{
        print_string("Unknown command: ");
        print_string(input);
    }
    print_string("\n> ");
}
