@echo off

echo *****************************************
echo Doing the ROM thing...
echo *****************************************

@echo off

del *.temp

del rom_compressed.o
del rom_uncompressed.o

del rom_compressed.rom
del rom_uncompressed.rom

del myfile.exe.crunched

tools\crunch -p myfile.exe myfile.exe.crunched

dockermake -f build_roms.mk



