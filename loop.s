.equ SWI_Exit, 0x11
@ mov r1, #2

cmp r1, #2   @prepare to compare r1
blt loop @check if r1 < 10
b exit @if false then func2 is triggered

loop:
    adds r1,r1,#1
    cmp r1, #10
    blt loop @check if r1 < 10
    b exit @if false then func2 is triggered
exit:
    swi SWI_Exit