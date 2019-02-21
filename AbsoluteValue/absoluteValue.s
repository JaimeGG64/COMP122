File: .asciz "INT.TXT"

ldr r0,=File @ set Name for input file
mov r1,#0 @ mode is input

swi 0x66 @open file
swi 0x6c @SWI_RdInt

mov r1,r0
mov r0,#1

sub r0,r2,r1

mov r1,r0
mov r0,#1

@ mvn r1, r0

@ cmp   r1, #0
@ movle r1, 

swi 0x6b @SWI_PrInt
swi 0x68 @close file
swi 0x11 @exit