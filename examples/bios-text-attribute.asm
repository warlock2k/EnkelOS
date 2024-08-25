; bootloader.asm
BITS 16           ; This is a 16-bit code
ORG 0x7C00        ; Origin, BIOS loads the bootloader here

start:
    mov ah, 0x09  ; BIOS function to write character and attribute
    mov al, 'A' ; make al store value 0x65
    mov bh, 0x00
    mov bl, 0x75 ; for color red on white background
    mov cx, 1

    ; Initialize cursor position
    mov dh, 8  ; Initial row (start at the top of the screen)
    mov dl, 0x00  ; Initial column (start at the first column)
    mov ah, 0x02 ; BIOS function to adjust cursor
    int 0x10

    call print    ; Call the print function

hang:
    jmp hang      ; Infinite loop to halt execution

print:
    ; if we reached z, hlt
    cmp al, 91
    je .done      ; If the byte is zero (end of string), jump to done
    
    ; print character in al
    mov ah, 0x09
    int 0x10      ; BIOS interrupt to print character with attributes
    inc al

    ; increment cursor position
    inc dl
    mov ah, 0x02
    int 0x10

    jmp print

.done:
    ret           ; Return from print function

times 510-($-$$) db 0 ; Pad rest of the bytes with 0, except the last two.
dw 0xAA55              ; Boot signature

