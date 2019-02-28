File: .asciz "INT.TXT"

ldr r0,=File @ set Name for input file
mov r1,#0 @ mode is input

swi 0x66 @open file
swi 0x6c @SWI_RdInt

mov r1,r0
mov r0,#1

CMP   r1, #10   ; if (x <= 0)
MOVLE r1, #0
MOVGT r1, #2   ; else x = 1;

@ compare
@     CMP   r1, #6   
@     MOVLE r1, #0
@     MOVGT r1, #1

swi 0x6b @SWI_PrInt
swi 0x68 @close file
swi 0x11 @exit

@ Use the Java code above to write equivalent ARM assembly code for it
@ You need to use branch and conditional branches
@ unconditional branch   b
@ conditional branch       bpl, bmi, beq ,....