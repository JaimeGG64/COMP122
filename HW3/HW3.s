@ 1. Change every character that occurs right after “.” Such as ‘i’ in ‘i am’
@ 2. If you run into a numerical number and if it is ‘122’ or ‘222’ then the previous two characters need to be capitalized. In this example, cs 122 and cs 222 need to be CS 122 and CS 222
InFileName: 
    .asciz "input.txt"
InFileError: .asciz "No File\n"
    .align
InFileHandle: .word 0

OutFileName: 
    .asciz "output.txt"
OutFileError: .asciz "No File\n"
    .align
CharArray: .skip 80

OutFileHandle: .word 0

.equ SWI_Print_Char, 0x00
.equ SWI_Print_String, 0x02
.equ SWI_RdStr, 0x6a
.equ SWI_PrInt, 0x6b
.equ SWI_RdInt, 0x6c
.equ SWI_Exit, 0x11
.equ SWI_Open, 0x66
.equ SWI_Close, 0x68
.equ SWI_PrStr, 0x69


_start:
    ldr r0,=InFileName
    mov r1,#0
    swi SWI_Open
    ldr r1,=CharArray
    mov r2,#80
    swi SWI_RdStr

    mov r4, #80
    cmp r4,#80
    b read_sentance

    ldr r0,=OutFileName
    mov r1,#1
    swi SWI_Open
    mov r1,r4
	swi SWI_PrStr

read_sentance:
    ldrb r0, [r1]

    bl print

    add r1,r1, #1
    add r5,r5, #1

    sub r4, r4, #1
    
    cmp r4, #0
    bne read_sentance
    b _exit

print:
    swi SWI_Print_Char
	strb r0,[r1]
	mov pc, r14

_exit:
    swi SWI_Exit