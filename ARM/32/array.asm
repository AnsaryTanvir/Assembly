.global _start
.section .text

_start:	
	MOV R0, #0		@ 	COUNTER FOR ITERATION
	LDR R1, =array  @ 	POINTER TO ARRAY
	
LOOP:
	CMP R0, #3		@	COMPARE COUNTER WITH 3
	BLT BODY		@ 	BRANCH IF COUNTER IS LESS THAN 3
	BAL END			@	END
	
BODY:
	MOV R2, #4		@	ELEMENT SIZE 4 BYTES
	MUL R3, R2, R0	@	INCREASE ITERATOR BY 1 BLOCK ( 4 BYTES )
	LDR R4, [R1,R3]	@	LOAD DATA INTO REGISTER FROM ARRAY USING OFFSET R3
	ADD R0, R0, #1	@	INCREMENT COUNTER BY 1
	BAL LOOP		@	BRANCH TO CODITION CHECKING
	
END:
	MOV R7, #1		@	SYCALL NUMBER FOR EXIT 1	
	MOV R0, #0		@	PROGRAM RETURN VALUE 0
	SWI 0			@	SOFTWARE INTERRUPT

.section .data
array:
	.word 1 , 2 , 3
	
	
@ BAL -> Branch always unconditionally
@ BGT -> Branch if greater than
@ BGE -> Branch if greater than or equal 
@ BLT -> Branch if less than
@ BLE -> Branch if less than or equal
@ BEQ -> Branch if equal
@ BNE -> Branch if not equal