
all: compressed uncompressed


compressed:

	mipsel-linux-gnu-as -o rom_compressed.o rom_compressed.s

	mipsel-linux-gnu-ld -T ./nugget/rom.ld -Ttext 0x1F000000 --oformat binary -o rom_compressed.rom rom_compressed.o

uncompressed:

	mipsel-linux-gnu-as -o rom_uncompressed.o rom_uncompressed.s

	mipsel-linux-gnu-ld -T ./nugget/rom.ld -Ttext 0x1F000000 --oformat binary -o rom_uncompressed.rom rom_uncompressed.o
		
clean:

	rm -f *.o
	rm -f *.exe
	rm -f *.temp
	rm -f *.bin
	echo done cleaning

#LDFLAGS += -Xlinker --defsym=EXE_COMPRESSED=USECOMPRESSION
