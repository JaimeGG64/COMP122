File: .asciz "INT.TXT"

ldr r0,=File @ set Name for input file
mov r1,#0 @ mode is input

swi 0x66 @open file
swi 0x6c @SWI_RdInt

mov r1,r0
mov r0,#1

cmp r1, #0
sub r0,r2,r1 @manipulate the value

movmi r1,r0 @when num < 0 change sign
mov r0,#1

swi 0x6b @SWI_PrInt
swi 0x68 @close file
swi 0x11 @exit