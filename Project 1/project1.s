File: .asciz "integers.txt"
check_num_of_integers_Message: .asciz " integers"
.equ SWI_Exit, 0x11
.equ SWI_Print_String, 0x02
.equ SWI_Open, 0x66
.equ SWI_PrInt, 0x6b
.equ SWI_RdInt, 0x6c

_start:
    ldr r0,=File @ set Name for input file
    mov r1,#0 @ mode is input

    swi SWI_Open @open file
    swi SWI_RdInt @SWI_RdInt
    mov r1,r0
    mov r0,#1
    cmp   r1, #10   @prepare to compare r1
    b _exit

check_num_of_integers:
num_of_int_greater_than_x:
set_x:
highest_int:

_exit:
    swi SWI_PrInt @SWI_PrInt
    ldr r0, =check_num_of_integers_Message
    swi SWI_Print_String
    swi 0x68 @close file
    swi SWI_Exit @exit
