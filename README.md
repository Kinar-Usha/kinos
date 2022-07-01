# Hobbyist 32-Bit Operating System

A minimal and experimental OS written from scratch.
Target architecture - x86
## Current Status
1. BYOB (Bring Your Own Bootloader)
2. GDT, Protected mode
3. VGA Graphic Driver
4. IDT, IRQ, ISR
5. Keyboard support
6. Memory Management - Heap


A script to download and compile a cross-compiler.

## Getting Started
### To install toolchain and necessary tools
``` 
cd tool
sudo apt update && sudo apt upgrade.
sudo apt install build-essential bison flex libgmp3-dev libmpc-dev libmpfr-dev texinfo nasm qemu-system-x86
make
```
### To run the OS
```
cd ..
make
```
### cleaning
```
make clean
```



### SS
[Qemu](https://imgur.com/a/J3er9YM)
