.equ SWI_Print_Int, 0x6B
	.equ SWI_Exit, 0x11
	.equ SWI_Print_Char, 0x00

	.data
array:
	.word 3,-7,2,-2,10

	.text
	.global _start
_start:
	;; because we know the array is non-empty, this code
	;; effectively does:
	;;
	;; int* r2 = array; // r2 holds the address of an integer
	;; int r3 = 5;
	;; do {
	;;   println(*r2);
	;;   r2++;
	;;   r3--;
	;; } while (r3 != 0);
	;;

	
	;; r2: address of current element
	;; r3: number of elements left to print
	ldr r2, =array 		; start on first element
	mov r3, #5 		; 5 elements to print
    mov r4, #0

loop_begin:
	;; print current element
	ldr r1, [r2] 		; read integer from array

	;; print a newline

	;; increment to the next array element
	;; add 4 because words are 4 bytes long
	add r2, r2, #4

    add r4, r1, r4 ;; Adds up the integers
	
	;; decrement number of elements left
	sub r3, r3, #1


	;; if we have none left, we're done
	cmp r3, #0
    
	bne loop_begin		; while (counter != 0)

    mov r0, #1
    mov r1, r4
    swi SWI_Print_Int
	
    ;; exit the program
	swi SWI_Exit
	.end
	