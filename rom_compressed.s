# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at https://mozilla.org/MPL/2.0/.

#
# The binary header is in rom_shared.s
# (for compressed and uncompressed .exe versions)
#

l_shared:
            .include    "rom_shared.s"
            .align 4


#
# Decompresses an .exe from ROM into RAM
# the file must be compressed with crunchykiller's -p param
#
# a0 = where's the data?
#
LoadMe:

            move    $a3, $a0            # we know BK_Decrunch doesn't use this register
            nop                         # so hold on to it for the crunchykiller header loc

            addiu   $a0, $a3, 0x10
            lw      $a1, 0x8($a3)       # addr from the crunchykiller header
            nop
            jal     BK_Decrunch
            nop

            # get the jump addr and stack pointer from the rest of the header
            lw      $t1, 0x0($a3)
            lw      $sp, 0x0c($a3)
            nop
            jr      $t1
            nop
            
l_decrunch:
            .include "rom_decrunch.s"
            nop
            

#
# marker for debugging in IDA/Hex view
#
binmark:
            .string     "-INCBIN-"
            nop
            .align 4

#
# The end of the assembly, myfile.exe is glued on the end
#
exe_01:
            
            .incbin "myfile.exe.crunched"
            .align 4

            # If you're appending a file to the end manually (cat/copy/etc)
            # remember to check that the compiler isn't adding extra bytes!
            # assemblers generally won't, the GNU toolchain does.

            