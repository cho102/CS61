;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Cindy Ho
; Email: cho102@ucr.edu
; 
; Assignment name: Assignment 2
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

;----------------------------------------------
;output prompt
;----------------------------------------------	

LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
;INSERT YOUR CODE here
;--------------------------------
GETC
OUT
ADD R1, R0, #0

LEA R0, newline
PUTS

GETC
OUT
ADD R2, R0, #0

LEA R0, newline
PUTS

ADD R0, R1, #0
OUT
LEA R0, subt
PUTS
ADD R0, R2, #0
OUT
LEA R0, equal
PUTS


NOT R2, R2
ADD R2, R2, #1
ADD R3, R1, R2
ADD R3, R3, #0
BRn	CONVERT_NEG
ADD R3, R3, #0
BRzp NOTHING_ZP

CONVERT_NEG
	LEA R0, negve
	PUTS
	NOT R3, R3
	ADD R3, R3, #1
	ADD R3, R3, #0
	BRzp NOTHING_ZP
	

NOTHING_ZP
	ADD R3, R3, x9
	ADD R3, R3, x9
	ADD R3, R3, x9
	ADD R3, R3, x3
	ADD R0, R3, #0
	OUT
	LEA R0, newline
	PUTS

	




HALT				; Stop execution of program
;------	
;Data
;------
subt	.STRINGZ	" - "
equal	.STRINGZ	" = "
negve	.STRINGZ	"-"

; String to prompt user. Note: already includes terminating newline!
intro 	.STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline .FILL '\n'	; newline character - use with LD followed by OUT


;---------------	
;END of PROGRAM
;---------------	
.END

