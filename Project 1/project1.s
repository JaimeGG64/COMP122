@ Name: Jaime Garcia
@ Date: 03-28-2019

@ r3 will hold the SWI_Open value
@ r4 will be 'x'
@ r5 keep track of int

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
    ldr r0,=File
    mov r1,#0
    swi SWI_Open
    mov r3,r0
    cmp r0,#-1
    beq no_file
    swi SWI_RdInt
    mov r2, r0 @temporary input
    mov r5, r0 @assign 'x'
    mov r7, r5
    mov r0,#0
    cmp r0, #0
    beq read_integers


read_integers:
    mov r0,r3
    mov r1,#0
    swi SWI_RdInt
    mov r2,r0
    adds r4, r4, #1
    cmp r0, #3
    beq _exit
    cmp r2, r7
    bgt highest_int
    cmp r2, r5
    bgt num_of_int_greater_than_x
    b read_integers

highest_int:
    mov r7, r2
    cmp r2, r5
    bgt num_of_int_greater_than_x
    b read_integers

num_of_int_greater_than_x:
    adds r6, r6, #1
    b read_integers

no_file:
    mov r1,#0
    swi SWI_Exit @exit

_exit:
    swi SWI_PrInt @SWI_PrInt
    swi SWI_Print_String
    swi SWI_Close @close file
    swi SWI_Exit @exit