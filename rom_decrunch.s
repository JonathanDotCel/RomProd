# ByteKiller decrunch code for PSX by Silpheed of Hitmen
#
# Ever so slightly tweaked for Unirom, 2013, 2020 ~Sickle
#

# BK_Decrunch
# a0 - src
# a1 - dest

#======================================================
# Decrunch - Omnomnom
#======================================================

BK_Decrunch:


        addiu   $sp, $sp, -0x4
        sw      $ra, 0($sp)

        move    $t0, $a0                # t0 = source address
        nop
        lw      $t2, 0($a0)             # t2 = uncompressed size
        move    $t1, $a1                # t1 = write address
        lw      $t3, 4($a0)             # t3 = compressed size
        addu    $t2, $t2, $t1           # t2 = uncompressed size + write address (end of write)
        addu    $t0, $t0, $t3           # t3 = compressed size + read address ( end of read )
        addiu   $t0, $t0, -4            # t0 = end of read address -4#
        lw      $t3, 0($t0)             # preload first word from t0 ( srcend -4 )
        nop

#======================================================
# BK_mainloop
#======================================================

BK_mainloop:

        jal     BK_getnextbit
        nop

        beq     $0, $v0, _BK_part2
        nop

        li      $a0, 2
        jal     BK_readbits
        nop

        slti    $t4, $v0, 2
        beq     $0, $t4, _BK_skip1
        nop

        addiu   $a0, $v0, 9
        addiu   $a1, $v0, 2
        jal     BK_dodupl
        nop

        b       _BK_endloop
        nop

_BK_skip1:

            addiu   $t4, $v0, -3
            bne     $0, $t4, _BK_skip2
            nop

            li      $a0, 8
            li      $a1, 8
            jal     BK_dojmp
            nop

            b _BK_endloop
            nop

_BK_skip2:
                jal     BK_readbits
                li      $a0, 8

                move    $a1, $v0
                li      $a0, 12
                jal     BK_dodupl
                nop

                b       _BK_endloop
                nop
_BK_part2:
                jal     BK_getnextbit
                nop

                beq     $0, $v0, _BK_skip3
                nop

                li      $a0, 8
                li      $a1, 1
                jal     BK_dodupl
                nop

                b       _BK_endloop
                nop

_BK_skip3:
                li      $a0, 3
                move    $a1, $0
                jal     BK_dojmp
                nop

_BK_endloop:
                bne     $t2, $t1, BK_mainloop
                nop


                lw      $ra, 0($sp)
                nop
                jr      $ra
                addiu   $sp, $sp, -0x4

#======================================================
# BK_getnextbit
#======================================================

BK_getnextbit:

        addiu   $sp, $sp, -0x4
        sw      $ra, 0($sp)
        nop

        andi    $v0, $t3, 1
        srl     $t3, $t3, 1
        bne     $0, $t3, _BK_gnbend
        nop

        addiu   $t0, $t0, -4
        lw      $t3, 0($t0)
        nop
        andi    $v0, $t3, 1
        srl     $t3, $t3, 1
        lui     $t5, 0x8000
        or      $t3, $t3, $t5

_BK_gnbend:

        lw      $ra, 0($sp)
        nop
        jr      $ra
        addiu   $sp, $sp, 0x4

#======================================================
# BK_readbits
#======================================================

BK_readbits:

        addiu   $sp, $sp, -0x4
        sw      $ra, 0($sp)
        nop

        move    $v1, $zero

_BK_rbloop:

        beq     $0, $a0, _BK_rbend
        nop

        addiu   $a0, $a0, -1

        sll     $v1, $v1, 1
        jal     BK_getnextbit
        nop
        or      $v1, $v1, $v0

        b       _BK_rbloop
        nop

_BK_rbend:
        move    $v0, $v1

        lw      $ra, 0($sp)
        nop
        jr      $ra
        addiu   $sp, $sp, 0x4

#======================================================
# BK_dojmp
#======================================================

BK_dojmp:

        addiu   $sp, $sp, -0x4
        sw      $ra, 0($sp)
        nop

        jal     BK_readbits
        nop

        addu    $t4, $v0, $a1
        addiu   $t4, $t4, 1
        nop

_BK_djloop:

        beq     $0, $t4, _BK_djend
        nop

                addiu   $t4, $t4, -1

                li      $a0, 8
                addiu   $t2, $t2, -1
                nop
                jal     BK_readbits
                nop

                sb      $v0, 0($t2)
                nop

                b       _BK_djloop
                nop

_BK_djend:

        lw      $ra, 0($sp)
        nop
        jr      $ra
        addiu   $sp, $sp, 0x4

#======================================================
# BK_dodupl
#======================================================

BK_dodupl:

        addiu   $sp, $sp, -0x4
        sw      $ra, 0($sp)
        nop

        move    $t7, $ra
        addiu   $a1, $a1, 1

        jal     BK_readbits
        nop

_BK_ddloop:

        beq     $0, $a1, _BK_ddend
        nop

        addiu   $a1, $a1, -1

        addiu   $t2, $t2, -1
        addu    $t4, $t2, $v0
        lb      $t4, 0($t4)
        nop
        sb      $t4, 0($t2)
        nop

        b       _BK_ddloop
        nop

_BK_ddend:

        lw      $ra, 0($sp)
        nop
        jr      $ra
        addiu   $sp, $sp, 0x4
