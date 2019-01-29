		
	MOV r0, #0
LOOP
	ADD r0, r0, #1 
	CMP r0, #10
	BNE LOOP

END
