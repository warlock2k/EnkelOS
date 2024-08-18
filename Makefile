OUTPUT = bootloader.bin
SOURCE = bootloader.asm

ASM = nasm
ASM_FLAGS = -f bin

all: $(OUTPUT)

$(OUTPUT):$(SOURCE)
	nasm $(ASM_FLAGS) -o $(OUTPUT) $(SOURCE)

clean:
	rm -f $(OUTPUT)

run: $(OUTPUT)
	qemu-system-x86_64.exe $(OUTPUT)