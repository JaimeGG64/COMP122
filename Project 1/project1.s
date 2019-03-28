@ Name: Jaime Garcia
@ Date: 03-28-2019

@ r3 will be handle the loop count
@ r4 will be 'x'
@ r5 

File: .asciz "integers.txt"
InFileError: .asciz "Unable to open file"
    .align
InFileHandle: .word 0
check_num_of_integers_Message: .asciz " integers"
.equ SWI_Exit, 0x11
.equ SWI_Print_String, 0x02
.equ SWI_Open, 0x66
.equ SWI_RdStr, 0x6a
.equ SWI_PrInt, 0x6b
.equ SWI_RdInt, 0x6c
.equ SWI_Close, 0x68

_start:
    ldr r0,=File @ set Name for input file
    mov r1,#0 @ mode is input
    swi SWI_Open @open file
    mov r3,r0 @store x
    mov r2,r0
    swi SWI_RdInt
    mov r2,r0
    mov r0,#0
    mov r5,#0
    cmp r0, #0 @prepare to compare r1
    beq read_integers


read_integers:
    mov r0,r3
    mov r1,#0
    swi SWI_RdInt
    cmp r0, #0
    adds r5, r5, #1
    b read_integers

check_num_of_integers:
num_of_int_greater_than_x:


highest_int:

_exit:
    swi SWI_PrInt @SWI_PrInt
    swi SWI_Print_String
    swi SWI_Close @close file
    swi SWI_Exit @exit
