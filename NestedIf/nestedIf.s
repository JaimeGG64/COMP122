File: .asciz "INT.TXT"

ldr r0,=File @ set Name for input file
mov r1,#0 @ mode is input

swi 0x66 @open file
swi 0x6c @SWI_RdInt
swi 0x68 @close file

mov r1,r0 @push r0 to r1
mov r0,#1 @set r0 to 1

cmp   r1, #10   @prepare to compare r1
blt func1 @check if r1 < 10
b func2 @if false then func2 is triggered

func1:
   cmp r1, #6 @prepare to compare r1
   movle r1, #0 @check if r1 <= 6 then set r1 = 0
   movgt r1, #1 @else set r1 = 1
   b print @ print r1
func2:
   mov r1, #2 @set r1 = 2
   b print @print r1
print: 
   swi 0x6b @SWI_PrInt
   swi 0x11 @exit