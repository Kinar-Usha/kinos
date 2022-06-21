# $@ = target file
# $< = first dependency
# $^ = all dependencies

TOOLCHAIN_BIN=~/toolchain/i686-elf/bin
TOOLCHAIN_PREFIX?=i686-elf
TARGET_GCC=~/toolchain/i686-elf/bin/i686-elf-gcc
TARGET_LD= ~/toolchain/i686-elf/bin/i686-elf-ld


C_SOURCES = $(wildcard kernel/*.c drivers/*.c cpu/*.c)
HEADERS = $(wildcard kernel/*.h  drivers/*.h cpu/*.h)
OBJ_FILES = ${C_SOURCES:.c=.o cpu/interrupt.o}


all: run

kernel.bin: boot/kernel_entry.o ${OBJ_FILES}
	$(TARGET_LD) -m elf_i386 -o $@ -Ttext 0x1000 $^ --oformat binary

os-image.bin: boot/mbr.bin kernel.bin
	cat $^ > $@


run: os-image.bin
	qemu-system-i386 -fda $<


%.o: %.c ${HEADERS}
	$(TARGET_GCC) -m32 -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -o $@



clean:
	$(RM) *.bin *.o *.dis *.elf
	$(RM) kernel/*.o
	$(RM) boot/*.o boot/*.bin
	$(RM) drivers/*.o
	$(RM) cpu/*.o
	$(RM) boot/kernel_entry.o
