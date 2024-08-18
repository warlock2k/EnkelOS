; bootloader.asm
BITS 16           ; This is a 16-bit code
ORG 0x7C00        ; Origin, BIOS loads the bootloader here

start:
    mov si, msg   ; Load address of message into SI register
    call print    ; Call the print function

hang:
    jmp hang      ; Infinite loop to halt execution

print:
    mov ah, 0x0E  ; BIOS teletype function to print a character
.print_loop:
    lodsb         ; Load byte at address SI into AL, increment SI
    cmp al, 0
    je .done      ; If the byte is zero (end of string), jump to done
    int 0x10      ; BIOS interrupt to print character in AL
    jmp .print_loop

.done:
    ret           ; Return from print function

msg db 'Hello, World!', 0  ; Our message, null-terminated

times 510-($-$$) db 0 ; Fill the rest of the 512 bytes with zeros
dw 0xAA55              ; Boot signature

