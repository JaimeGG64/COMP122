@ 1. Change every character that occurs right after “.” Such as ‘i’ in ‘i am’
@ 2. If you run into a numerical number and if it is ‘122’ or ‘222’ then the previous two characters need to be capitalized. In this example, cs 122 and cs 222 need to be CS 122 and CS 222
InFileName: 
    .asciz "input.txt"
InFileError: .asciz "No File\n"
    .align

OutFileName: 
    .asciz "output.txt"
OutFileError: .asciz "No File\n"
    .align

HandleFile: .skip 60

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
    ldr r1,=HandleFile
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
    bl print_to_console
    add r1,r1, #1
    add r5,r5, #1

    sub r4, r4, #1

    cmp r0, #46
    beq capitalized_letter
    
    cmp r4, #0
    bne read_sentance
    b _exit

capitalized_letter:
    ldrb r0, [r1]
    cmp r0, #32
    addeq r1, r1, #1
	addeq r5, r5, #1
    swieq SWI_Print_Char
    beq capitalized_letter
    sub r0,r0,#32
    bl print_to_console
    add r1,r1,#1
    add r5,r5,#1
    b read_sentance

capitalized_course:
    add r1,r1,#3

print_to_console:
    cmp r0, #-32
    beq _exit
    swi SWI_Print_Char
	strb r0,[r1]
	mov pc, r14

save_to_file:
	sub r1, r1, r5
	mov r4, r1
	ldr r0, =OutFileName
	mov r1,#1 
	swi SWI_Open 
	mov r1,r4 
	swi SWI_PrStr 
	mov pc, r14

_exit:
    bl save_to_file
    swi SWI_Close
    swi SWI_Exit