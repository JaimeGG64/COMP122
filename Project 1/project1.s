@ Name: Jaime Garcia
@ Date: 03-28-2019

@ ******************Notes******************
@ r3 will hold the SWI_Open value
@ r4 will be 'x'
@ r5 keep track of int

File: .asciz "integers.txt"
InFileError: .asciz "Unable to open file"
    .align
InFileHandle: .word 0

check_num_of_integers_message_pt_one: .asciz "File contains "
check_num_of_integers_message_pt_two: .asciz " integers, "
set_x_message: .asciz "First integer x is "
greater_than_x_message_pt_one: .asciz ", Thare are " 
greater_than_x_message_pt_two: .asciz " integers greater than "
largest_integer_message: .asciz " and the maximum positive integer is "

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
    beq print_full_output
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

print_full_output:
    ldr r0, =check_num_of_integers_message_pt_one
    swi SWI_Print_String
    mov r1,r4
    mov r0,#1
    swi SWI_PrInt
    ldr r0, =check_num_of_integers_message_pt_two
    swi SWI_Print_String

    ldr r0, =set_x_message
    swi SWI_Print_String
    mov r1,r5
    mov r0,#1
    swi SWI_PrInt

    ldr r0, =greater_than_x_message_pt_one
    swi SWI_Print_String
    mov r1,r6
    mov r0,#1
    swi SWI_PrInt
    ldr r0, =greater_than_x_message_pt_two
    swi SWI_Print_String
    mov r1,r5
    mov r0,#1
    swi SWI_PrInt

    ldr r0, =largest_integer_message
    swi SWI_Print_String
    mov r1,r7
    mov r0,#1
    swi SWI_PrInt

_exit:
    
    swi SWI_Close
    swi SWI_Exit