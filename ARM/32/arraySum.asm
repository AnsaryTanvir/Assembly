.global _start
.section .text

/*
	When calling a function on ARM, the first 4 arguments is stored in general-purpose
	registers R0-R3. If the function has more than 4 arguments, the remainder is 
	pushed into the stack and the SP register is changed accordingly.
	Then the function address will be put into PC register and the return address 
	in LR register.

	When the function finished execution, the return value will reside in R0 register.
*/

SUM:
	MOV R2, #0				@ R2 Sum variable
	MOV R3, #0				@ R3 Iterator
	
	LOOP:
		cmp R3, R1			@ Compare iterator with length
		BLT	ADDITION		@ Branch if iterator is less than length
		BAL FINISHED
	
	ADDITION:
		MOV R5, #4			@ Element size 4 bytes
		MUL R5, R5, R3  	@ Get the element offset
		LDR R4, [R0, R5]	@ Load array element with offset
		ADD R2, R2, R4		@ SUM = SUM + Element
		ADD R3, R3, #1		@ Increment iterator by 1
		BAL	LOOP			@ Branch back to where loop started
	
	FINISHED:
	MOV R0, R2				@ Return value stored in R0
	BX LR					@ Branch back to caller 

_start:

	LDR R0, =array     @ R0 Pointer to array
	MOV R1, #5         @ R1 Length  of array
	BL SUM             @ Branch & Link calee
	ADD R0, #0         @ R0 Holds return value
	
	MOV R7, #1		   @	SYCALL NUMBER FOR EXIT 1	
	MOV R0, R0		   @	PROGRAM RETURN VALUE 0
	SWI 0			   @	SOFTWARE INTERRUPT
	
.section .data
array:
	.word 1,2,3,4,5
 
