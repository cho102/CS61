;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Cindy Ho
; Email: cho102@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 23
; TA: Dipan Shaw
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R5
;=================================================================================

					.ORIG x3000		
;-------------
;Instructions
;-------------

START_OF_PROGRAM

LD R0, introPromptPtr ; output intro prompt
PUTS


;R0 INPUT
;R1 OFFSET CHECKER
;R2 TEMP HOLDER
;R3 COUNTER
;R4 FLAG NEG/POS
;R5 WHERE NUMBER WILL BE STORED
;R6 MULTIPLIER
					
; Set up flags, counters, accumulators as needed
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

LD R3, COUNTER

FIRST_CHAR_INPUT
	GETC						; Get first character, test for '\n', '+', '-', digit/non-digit 						
	OUT

	LD R1, ENDL_OFFSET		; is very first character = '\n'? if so, just quit (no message)!
	ADD R2, R0, R1
	BRz END_OF_PROGRAM


	LD R1, ADDITION			; is it = '+'? if so, ignore it, go get digits
	ADD R2, R0, R1
	BRz GET_DIGITS
	
	LD R1, MINUS			; is it = '-'? if so, set neg flag, go get digits
	ADD R2, R0, R1
	BRz SET_NEG_FLAG

	LD R1, ZERO				; is it < '0'? if so, it is not a digit	- o/p error message, start over
	ADD R2, R0, R1
	BRn ERROR_MSG

	LD R1, NINE				; is it > '9'? if so, it is not a digit	- o/p error message, start over
	ADD R2, R0, R1
	BRp ERROR_MSG	
	
	ADD R3, R3, #-1
	LD R1, ZERO
	ADD R0, R0, R1
	ADD R5, R5, R0
	BRnzp GET_DIGITS


GET_DIGITS					; if none of the above, first character is first numeric digit - convert it to number & store in target register!
	GETC
	OUT
	
	LD R1, ENDL_OFFSET		; is very first character = '\n'? if so, just quit (no message)!
	ADD R2, R0, R1
	BRz CHECK_NEG

	LD R1, ZERO				; is it < '0'? if so, it is not a digit	- o/p error message, start over
	ADD R2, R0, R1
	BRn ERROR_MSG

	LD R1, NINE				; is it > '9'? if so, it is not a digit	- o/p error message, start over
	ADD R2, R0, R1
	BRp ERROR_MSG	
	
	LD R1, ZERO
	ADD R0, R0, R1
	BRnzp CONVERTING

CONVERTING
	LD R6, TEN_COUNT
	AND R2, R2, #0
	ADD R2, R2, R5
	BRnzp MULTIPLY_BY_TEN

MULTIPLY_BY_TEN
	ADD R5, R5, R2
	ADD R6, R6, #-1
	BRp MULTIPLY_BY_TEN
	ADD R6, R6, #0
	BRnzp ADD_R0

ADD_R0
	ADD R5, R5, R0
	ADD R3, R3, #-1
	BRp GET_DIGITS
	ADD R3, R3, #0
	BRz CHECK_NEG

	












					
; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator

ERROR_MSG
	LD R0, ENDLINE
	OUT
	LD R0, errorMessagePtr
	PUTS
	BRnzp START_OF_PROGRAM

SET_NEG_FLAG
	ADD R4, R4, #1
	BRnzp GET_DIGITS
	
CHECK_NEG
	ADD R4, R4, #-1
	BRz CONVERT_NEG
	ADD R3, R3, #0
	BRz FINAL_PART
	ADD R3, R3, #0
	BRnp END_OF_PROGRAM

CONVERT_NEG
	NOT R5, R5
	ADD R5, R5, #1
	ADD R3, R3, #0
	BRz FINAL_PART
	ADD R3, R3, #0
	BRnp END_OF_PROGRAM

FINAL_PART
	LD R0, ENDLINE			; remember to end with a newline!
	OUT

END_OF_PROGRAM
					
					HALT

;---------------	
; Program Data
;---------------

introPromptPtr		.FILL xB000
errorMessagePtr		.FILL xB200
ZERO				.FILL	#-48
NINE				.FILL	#-57
MINUS				.FILL	#-45
ADDITION			.FILL	#-43
ENDL_OFFSET			.FILL	#-10
ENDLINE				.FILL	'\n'
COUNTER				.FILL	#5
TEN_COUNT			.FILL	#9

;------------
; Remote data
;------------
.ORIG xB000			; intro prompt
.STRINGZ	"Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
					
					
.ORIG xB200			; error message
.STRINGZ	"ERROR: invalid input\n"

;---------------
; END of PROGRAM
;---------------
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
