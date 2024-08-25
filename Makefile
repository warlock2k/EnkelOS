CFLAGS = -m32 -ffreestanding -O2 -Wall -Wextra
LDFLAGS = -T linker.ld

all: myos.bin

myos.bin: boot.o kernel.o
	i686-elf-gcc $(LDFLAGS) -o myos.bin boot.o kernel.o -nostdlib -lgcc

boot.o: boot.s
	i686-elf-as boot.s -o boot.o

kernel.o: kernel.c
	i686-elf-gcc $(CFLAGS) -c kernel.c -o kernel.o

clean:
	rm -f *.o myos.bin

run: myos.bin
	qemu-system-i386 -kernel myos.bin
