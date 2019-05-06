@ Author: Jaime Garcia Garcia
@ Name: Project 2
@ Date: 5/07/2019
@ Purpose: It will capitalized letter in the beginning of a sentance and course name. 

InFileName: 
    .asciz "input.txt"
InFileError: .asciz "No File\n"
    .align

OutFileName: 
    .asciz "output.txt"
OutFileError: .asciz "No File\n"
    .align

@ Set length for file
HandleFile: .skip 130

@ The swi codes
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
    @ Loads Up the file
    ldr r0,=InFileName
    mov r1,#0
    swi SWI_Open

    @ Checks if 'input.txt' exist file
    cmp r0, #-1
    beq no_file

    @ Set Up how program is going to read the .txt
    ldr r1,=HandleFile
    mov r2,#130
    swi SWI_RdStr
    mov r4, #130
    cmp r4,#130

    @ Once everything is set it branch to 'read_sentance'
    b read_sentance

    ldr r0,=OutFileName
    mov r1,#1
    swi SWI_Open
    mov r1,r4
	swi SWI_PrStr

read_sentance:
    @ r1 is read to r0
    ldrb r0, [r1]

    cmp r0, #44
    beq convert_to_asterisk
    cmp r0, #46
    beq convert_to_asterisk
    cmp r0, #59
    beq convert_to_asterisk

    bl print_to_console

    @ 'r1' will advance throught the string inside 'input.txt'
    add r1,r1, #1
    add r5,r5, #1
    sub r4, r4, #1

    @ If '.' is dedected then the program will branch to 'capitalized_letter'
    cmp r0, #32
    beq capitalized_letter
    

    cmp r4, #0
    bne read_sentance
    bl print_to_console
    b _exit

capitalized_letter:
    ldrb r0, [r1]
    cmp r0, #96
    @ When suptracing an ASCII lower case letter by 32 it will capitalize the letter
    subgt r0,r0,#32
    addle r1,r1,#1
    addle r5,r5,#1
    ble read_sentance
    b print_to_console

    @ This is advancing through the string
    add r1,r1,#1
    add r5,r5,#1
    b read_sentance

convert_to_asterisk:
    ldrb r0, [r1]
    mov r0,#42
    bl print_to_console
    add r1,r1,#1
    add r5,r5,#1
    b read_sentance

print_to_console:
    cmp r0, #-32
    beq _exit
    
    @ if (r1 != -32) Then the character will print to the console
    swi SWI_Print_Char
	strb r0,[r1]
    
    @ It will return back 'print_to_console was called to'
	mov pc, r14

save_to_file:
    @ Prepare to write to file
	sub r1, r1, r5
	mov r4, r1

    @ Locate the output file and prepare to write to file
	ldr r0, =OutFileName
	mov r1,#1 
	swi SWI_Open 
	mov r1,r4
    
    @ Print to file
	swi SWI_PrStr
    
    @ Reture to where this branch was invoked
	mov pc, r14

_exit:
    @ Before the application close it write to file
    bl save_to_file
    swi SWI_Close
    swi SWI_Exit

no_file:
    @ Prints a Message if there is no file
    ldr r0, =InFileError
    swi SWI_Print_String
    swi SWI_Exit