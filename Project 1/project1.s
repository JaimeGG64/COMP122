@ Name: Jaime Garcia
@ Date: 03-28-2019
@ Title: Project 1

@ *******************Special Notes*******************
@ r0-r7 will serve different purposes
    @ r0 - Handle files
    @ r1 - Specify the file modes
    @ r2 - Temporarly store the read integer
    @ r3 - will hold the SWI_Open value
    @ r4 - will be 'x'
    @ r5 - Keep track of the number of integers from the .txt file
    @ r6 - Keep track of the number of integers greater that 'x'
    @ r7 - Will store the largest integer
@ *****************End Special Notes*****************

File: .asciz "integers.txt"
FileError: .asciz "Unable to open file"
EmptyFileError: .asciz "Empty File"
InFileHandle: .word 0

@ A collection of Strings that the branch 'print_full_message' will string together to display the fulle message
check_num_of_integers_message_pt_one: .asciz "File contains "
check_num_of_integers_message_pt_two: .asciz " integers, "
set_x_message: .asciz "First integer x is "
greater_than_x_message_pt_one: .asciz ", Thare are " 
greater_than_x_message_pt_two: .asciz " integers greater than "
largest_integer_message: .asciz " and the maximum positive integer is "

@ To prevent misstyping the wrong opcode(ie. 0x11, 0x66, 0x6a) an .equ will be used base of the opcode action
.equ SWI_Exit, 0x11
.equ SWI_Print_String, 0x02
.equ SWI_Open, 0x66
.equ SWI_RdStr, 0x6a
.equ SWI_PrInt, 0x6b
.equ SWI_RdInt, 0x6c
.equ SWI_Close, 0x68

_start:
    @ Prepare to open and store the SWI_Open value to r3
    ldr r0,=File
    mov r1,#0
    swi SWI_Open
    mov r3,r0

    @ Checks if the file exists
    cmp r0,#-1
    beq no_file

    @ Reads the first first integer of the file and makes the assign them to the registers
    swi SWI_RdInt
    mov r2, r0 @ Store the integer temporarly
    mov r5, r0 @ Assign x
    mov r7, r5 @ Make the x the largest for the meantime
    mov r0,#0

    @ The Program then branch to read_integers
    cmp r0, #0
    beq read_integers

    @**end _start:**

read_integers:
    @ Restore the 'swi SWI_Open' value and is set to input mode
    mov r0,r3
    mov r1,#0

    @ Prepare to read the next integer
    swi SWI_RdInt
    mov r2,r0
    adds r4, r4, #1

    @ When there no integers it will print the full message
    cmp r0, #3
    beq print_full_message

    @ If the next integer larger than the initial largest integer(ie. r7) then 'largest_integer will be excuted'
    cmp r2, r7
    bgt largest_integer

    @ If the next integer than 'x' then 'num_of_int_greater_than_x' will be excuted
    cmp r2, r5
    bgt num_of_int_greater_than_x
    b read_integers
    
    @ **end read_integers:**

largest_integer:
    @ When excuted it will store the temporary r2 to r7
    mov r7, r2

    @ If the next integer than 'x' then 'num_of_int_greater_than_x' will be excuted
    cmp r2, r5
    bgt num_of_int_greater_than_x

    @ Return to read_integers
    b read_integers
    
    @ **end largest_integer:**

num_of_int_greater_than_x:
    @ Keep track of the number of integers greater than 'x'
    adds r6, r6, #1

    @ Return to read_integers
    b read_integers

    @ **end num_of_int_greater_than_x: **

no_file:
    @ Prints a Message if there is no file
    ldr r0, =FileError
    swi SWI_Exit

print_full_message:
    @ Strings the number of integers sentence together.
    ldr r0, =check_num_of_integers_message_pt_one
    swi SWI_Print_String
    mov r1,r4
    mov r0,#1
    swi SWI_PrInt
    ldr r0, =check_num_of_integers_message_pt_two
    swi SWI_Print_String

    @ String the value of 'x' sentence together
    ldr r0, =set_x_message
    swi SWI_Print_String
    mov r1,r5
    mov r0,#1
    swi SWI_PrInt

    @ Strings the number of integers greater than 'x' sentence together
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

    @ Strings the largest integer sentence together
    ldr r0, =largest_integer_message
    swi SWI_Print_String
    mov r1,r7
    mov r0,#1
    swi SWI_PrInt

    @ Close the file
    swi SWI_Close

    @ Terminate the program
    swi SWI_Exit    