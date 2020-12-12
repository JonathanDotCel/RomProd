@echo off

cls

echo cancel now if you didn't mean that...
echo all .rom files will be deleted.

pause

echo Cleaning loose files...

del *.rom
REM del *.exe
del *.sym
del *.map
del *.obj
del *.cpe
del *.dep
del *.temp
del *.crunch
del *.crunched
del *.o
del *.elf

del comport.txt

del stderr.txt
del stdout.txt

echo Cleaning IDA stuff...

del *.idb
del *.til
del *.id0
del *.id1
del *.nam
del *.i64

echo Cleaning via make

call dockermake -f build_roms.mk clean





