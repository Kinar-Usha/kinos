# $@ = target file
# $< = first dependency
# $^ = all dependencies

TOOLCHAIN_BIN=/home/kinar/toolchain/toolchain/i686-elf/bin
TOOLCHAIN_PREFIX?=i686-elf
TARGET_GCC=/home/kinar/toolchain/toolchain/i686-elf/bin/i686-elf-gcc
TARGET_LD= /home/kinar/toolchain/toolchain/i686-elf/bin/i686-elf-ld

all: run

kernel.bin: kernel_entry.o kernel.o
	$(TARGET_LD) -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	$(TARGET_GCC) -m32 -ffreestanding -c $< -o $@

mbr.bin: mbr.asm
	nasm $< -f bin -o $@

os-image.bin: mbr.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-i386 -fda $<

clean:
	$(RM) *.bin *.o *.dis
