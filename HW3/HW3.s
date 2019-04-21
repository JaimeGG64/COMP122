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

.equ SWI_Exit, 0x11
.equ SWI_Print_String, 0x02
.equ SWI_Open, 0x66
.equ SWI_RdStr, 0x6a
.equ SWI_PrInt, 0x6b
.equ SWI_RdInt, 0x6c
.equ SWI_Close, 0x68
.equ SWI_PrStr, 0x69


_start:
    ldr r0,=InFileName
    mov r1,#0
    swi SWI_Open
    mov r3, r0
    @ str r0,[r1]
    ;; load empty array 
    ldr r1,=CharArray
    mov r2,#80
    swi SWI_RdStr
    mov r4, r1

    ldr r0,=OutFileName
    mov r1,#1
    swi SWI_Open
    mov r1,r4
	swi SWI_PrStr
    swi SWI_Exit
    ;;str r0,[r3]
