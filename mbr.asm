[bits 16]
[org 0x7c00]

KERNEL_OFFSET equ 0x1000

mov [BOOT_DRIVE], dl
mov bp, 0x9000
mov sp, bp

call load_kernel
call switch_to_32bit
jmp $

%include "disk.asm"
%include "gdt.asm"
%include "switch-to-32bit.asm"



[bits 16]
load_kernel:
    mov bx, KERNEL_OFFSET
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret



[bits 32]
BEGIN_32BIT:
    call KERNEL_OFFSET
    jmp $

BOOT_DRIVE db 0


times 510 - ($-$$) db 0
dw 0xaa55