;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Cindy Ho
; Email: cho102@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 23
; TA: Dipan Shaw
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
;Instructions
;-------------
LD R6, Value_ptr		; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			; R1 <-- value to be displayed as binary 
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------

LD R2, BIT_COUNTER
LD R3, ZERO
LD R4, SPACE_COUNTER

CONVERT_LOOP
	ADD R1, R1, #0
	BRn	OUT_ONE
	BRzp	OUT_ZERO
		
CHECK_SPACE
	ADD R2, R2, #-1
	BRz	OUT_SPACE
	ADD R1, R1, #0
	BRnzp	CONVERT_LOOP
	
OUT_ZERO
	ADD R0, R3, #0
	OUT
	ADD R1, R1, R1
	BRnzp	CHECK_SPACE
	
OUT_ONE
	ADD R0, R3, #1
	OUT
	ADD R1, R1, R1
	BRnzp	CHECK_SPACE

OUT_SPACE
	ADD R4, R4, #0
	BRz	END_CONVERT_LOOP
	LEA R0, SPACE
	PUTS
	ADD R4, R4, #-1
	LD R2, BIT_COUNTER
	BRnp	CONVERT_LOOP
END_CONVERT_LOOP

LD R0, NEWLINE
OUT

HALT
;---------------	
;Data
;---------------
Value_ptr	.FILL xCA00	; The address where value to be displayed is stored

NEWLINE	.FILL	'\n'
SPACE	.STRINGZ	" "
ZERO	.FILL	#48
SPACE_COUNTER	.FILL #3
BIT_COUNTER	.FILL #4



.ORIG xCA00					; Remote data
Value .FILL xABCD			; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
;END of PROGRAM
;---------------	
.END
