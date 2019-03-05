File: .asciz "INT.TXT"

ldr r0,=File @ set Name for input file
mov r1,#0 @ mode is input

swi 0x66 @open file
swi 0x6c @SWI_RdInt

mov r1,r0
mov r0,#1

CMP   r1, #10   ; if (x <= 10)
bmi func1
b func2   ; else x = 1;

func1:
   cmp r1, #6
   mov r1, #0
   mov r1, #1
func2:
   mov r1, #2

swi 0x6b @SWI_PrInt
swi 0x68 @close file
swi 0x11 @exit

@ Use the Java code above to write equivalent ARM assembly code for it
@ You need to use branch and conditional branches
@ unconditional branch   b
@ conditional branch       bpl, bmi, beq ,....