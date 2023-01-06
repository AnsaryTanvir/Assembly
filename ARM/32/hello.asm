.global _start
.section .text

@ void print()
PRINT:

	PUSH { R0, R1, R2 }
	
	MOV R7, #4
	MOV R0, #1
	LDR R1, =message
	MOV R2, #12
	SWI 0
	
	POP { R0, R1, R2 }
	BX LR

@ void display(int times)
DISPLAY:

	PUSH {LR}
	MOV R1, #0

	LOOP:
		CMP R1, R0
		BLT BODY 
		BAL END
	BODY:
		BL PRINT
		ADD R1, R1, #1
		BAL LOOP		

	END:
		POP {LR}
		BX LR
			
_start:

	@ DISPLAY(3)
	MOV R0, #3
	BL DISPLAY
	
	MOV R7, #1
	MOV R0, #0
	SWI 0

.section .data
message:
	.ascii "Hello World\n"
