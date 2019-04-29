.equ SWI_PrChr, 0x00
.equ SWI_Exit, 0x11

data:
    .asciz "ABCDE"

_start:
    ldr r2,=data @point to string
    mov r3,#5 @set the length of the String

loop:
    ldrb r0,[r2] @pick up first byte
    swi SWI_PrChr @prints the single characters
    add r2,r2,#1 @index to next
    sub r3,r3,#1 @Subtracts the point
    cmp r3, #0 @prepare to compare
    bne loop @If not equal return to loop
    b _exit @Else exit

_exit:
    swi SWI_Exit @terminate the program
