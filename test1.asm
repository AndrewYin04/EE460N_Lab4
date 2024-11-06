.ORIG x3000
LEA R0, Location
LDW R0, R0, #0 ; r0 is 0x3100
LDB R1, R0, #0 ; r1 is the first num
LDB R2, R0, #1 ; r2 is the second num
AND R3, R3, #0 ; r3 is zero
loop ADD R2, R2, #0
     BRZ done
     AND R4, R2, #1
     BRZ skip
     ADD R3, R3, R1
skip RSHFL R2, R2, #1
     LSHF R1, R1, #1
     BR loop

done STB R3, R0, #2
     LEA R4, Last8
     LDW R4, R4, #0
     AND R3, R3, R4
     BRZ noOverflow
     AND R3, R3, #0
     ADD R3, R3, #1
     STB R3, R0, #3
     BR rlydone

noOverflow AND R3, R3, #0
           STB R3, R0, #3

rlydone

        ; Step 4: Cause desired exceptions

        ; Uncomment one of the following lines based on the exception you want to test:

        ; Protection Exception (Store sum at x0000)
        ; LEA   R1, PROTEXCEPTADDR
        ; LDW R1, R1, #0
        ; STW   R3, R1, #0

        ; Unaligned Access Exception (Store sum at xC017)
        ; LEA   R1, UNALIGNEDADDR
        ; LDW R1, R1, #0
        ; STW   R3, R1, #0

        ; Unknown Opcode Exception (Invalid opcode)
        ; .FILL xA000             ; An invalid opcode (1010)
        ; .FILL xB000           ; Invalid opcode (0b1011)

HALT
FirstNum .FILL x7f01
Answer .FILL xFFFF
Last8 .FILL xFF00
Location        .FILL x3032
.END

