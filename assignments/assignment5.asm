;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Cindy Ho
; Email: cho102@ucr.edu
; 
; Assignment name: Assignment 5
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
;-------------------------------
;INSERT CODE STARTING FROM HERE
;--------------------------------
;R1 RET VALUES FROM SUB
;R2 RET VALUES FROM SUB
;R3 CHECKER
;R6 CALL TO SUBROUTINES
	
START_PROGRAM

LD R6, MENU
JSRR R6

ADD R3, R1, #-1
BRz OPT_1
ADD R3, R1, #-2
BRz OPT_2
ADD R3, R1, #-3
BRz OPT_3
ADD R3, R1, #-4
BRz OPT_4
ADD R3, R1, #-5
BRz OPT_5
ADD R3, R1, #-6
BRz OPT_6
BRnzp OPT_7


OPT_1
	LD R6, ALL_MACHINES_BUSY
	JSRR R6	
	ADD R3, R2, #-1
	BRz BUSY_MACHINE
	ADD R3, R2, #0
	BRz NOT_BUSY_MACHINE	
BUSY_MACHINE
	LEA R0, allbusy
	PUTS
	BRnzp START_PROGRAM
NOT_BUSY_MACHINE
	LEA R0, allnotbusy
	PUTS
	BRnzp START_PROGRAM
		
			
OPT_2
	LD R6, ALL_MACHINES_FREE
	JSRR R6	
	ADD R3, R2, #-1
	BRz FREE_MACHINE
	ADD R3, R2, #0
	BRz NOT_FREE_MACHINE
FREE_MACHINE
	LEA R0, allfree
	PUTS
	BRnzp START_PROGRAM	
NOT_FREE_MACHINE
	LEA R0, allnotfree
	PUTS
	BRnzp START_PROGRAM
		
		
OPT_3
	LD R6, NUM_BUSY_MACHINES
	JSRR R6
	
	LEA R0, busymachine1
	PUTS
	
	LD R6, PRINT_NUM
	JSRR R6
	
	LEA R0, busymachine2
	PUTS
	BRnzp START_PROGRAM
		
		
OPT_4
	LD R6, NUM_FREE_MACHINES
	JSRR R6
	
	LEA R0, freemachine1
	PUTS
	
	LD R6, PRINT_NUM
	JSRR R6
	
	LEA R0, freemachine2
	PUTS
	BRnzp START_PROGRAM	


OPT_5
	LD R6, GET_MACHINE_NUM
	JSRR R6
	
	LEA R0, status1
	PUTS
		
	LD R6, PRINT_NUM
	JSRR R6

	LD R6, MACHINE_STATUS
	JSRR R6
	
	ADD R3, R2, #-1
	BRz IS_BUSY_MENU
	ADD R3, R2, #0
	BRz IS_FREE_MENU

IS_BUSY_MENU
	LEA R0, status2
	PUTS
	BRnzp START_PROGRAM

IS_FREE_MENU
	LEA R0, status3
	PUTS
	BRnzp START_PROGRAM
		
		
OPT_6
	LD R6, FIRST_FREE
	JSRR R6
	
	ADD R3, R1, #1
	BRz NOT_AVAILABLE

AVAILABLE
	LEA R0, firstfree1
	PUTS
	
	LD R6, PRINT_NUM
	JSRR R6
	
	LD R0, newline
	OUT
	
	BRnzp START_PROGRAM

NOT_AVAILABLE
	LEA R0, firstfree2
	PUTS
	BRnzp START_PROGRAM


OPT_7
	LEA R0, goodbye
	PUTS

END_PROGRAM

HALT
;---------------	
;Data
;---------------
;Subroutine pointers
MENU					.FILL		x3200
ALL_MACHINES_BUSY		.FILL		x3400
ALL_MACHINES_FREE		.FILL		x3600
NUM_BUSY_MACHINES		.FILL		x3800
NUM_FREE_MACHINES		.FILL		x4000
MACHINE_STATUS			.FILL		x4200
FIRST_FREE				.FILL		x4400
GET_MACHINE_NUM			.FILL		x4600
PRINT_NUM				.FILL		x4800

;Other data 
newline 		.fill '\n'

; Strings for reports from menu subroutines:
goodbye         .stringz "Goodbye!\n"
allbusy         .stringz "All machines are busy\n"
allnotbusy      .stringz "Not all machines are busy\n"
allfree         .stringz "All machines are free\n"
allnotfree		.stringz "Not all machines are free\n"
busymachine1    .stringz "There are "
busymachine2    .stringz " busy machines\n"
freemachine1    .stringz "There are "
freemachine2    .stringz " free machines\n"
status1         .stringz "Machine "
status2		    .stringz " is busy\n"
status3		    .stringz " is free\n"
firstfree1      .stringz "The first available machine is number "
firstfree2      .stringz "No machines are free\n"

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MENU
; Inputs: None
; Postcondition: The subroutine has printed out a menu with numerical options, invited the
;                user to select an option, and returned the selected option.
; Return Value (R1): The option selected:  #1, #2, #3, #4, #5, #6 or #7 (as a number, not a character)
;                    no other return value is possible
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MENU
;--------------------------------
.ORIG x3200
;HINT back up 
ST R1, BACKUP_R1_3200
ST R2, BACKUP_R2_3200
ST R3, BACKUP_R3_3200
ST R7, BACKUP_R7_3200

;R0 ORIG VALUE STORED
;R1 WHERE NUM WILL BE STORED/RET
;R2 CHECKER
;R3 OFFSET_CHECKER

START_SUB
LD R3, ZERO_OFFSET

LD R0, Menu_string_addr
PUTS

GETC
OUT
ADD R1, R0, R3

LD R0, ENDL
OUT
ADD R0, R0, R3

ADD R2, R1, #-1
BRn ERROR_INPUT

ADD R2, R1, #-7
BRp ERROR_INPUT

BRnzp END_SUB

ERROR_INPUT
	LEA R0, Error_msg_1
	PUTS
	BRnzp START_SUB


END_SUB

;HINT Restore
LD R2, BACKUP_R2_3200
LD R3, BACKUP_R3_3200
LD R7, BACKUP_R7_3200

RET
;--------------------------------
;Data for subroutine MENU
;--------------------------------
Error_msg_1	      .STRINGZ "INVALID INPUT\n"
Menu_string_addr  .FILL x5000

ZERO_OFFSET		.FILL	#-48
ENDL			.FILL	#10

BACKUP_R0_3200	.BLKW	#1
BACKUP_R1_3200	.BLKW	#1
BACKUP_R2_3200	.BLKW	#1
BACKUP_R3_3200	.BLKW	#1
BACKUP_R4_3200	.BLKW	#1
BACKUP_R5_3200	.BLKW	#1
BACKUP_R6_3200	.BLKW	#1
BACKUP_R7_3200	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_BUSY (#1)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are busy
; Return value (R2): 1 if all machines are busy, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_BUSY
;--------------------------------
.ORIG x3400
;HINT back up
ST R1, BACKUP_R1_3400
ST R2, BACKUP_R2_3400
ST R3, BACKUP_R3_3400
ST R4, BACKUP_R4_3400 
ST R7, BACKUP_R7_3400

;R1 POINTER VAL
;R2 RET VAL
;R3 BIT_COUNTER
;R4 LD POINTER

AND R2, R2, #0
LD R4, BUSYNESS_ADDR_ALL_MACHINES_BUSY
LDR R1, R4, #0
LD R3, BIT_COUNTER1

CHECK_ADDR
	ADD R1, R1, #0
	BRn NOT_BUSY ; ONE=FREE
	BRzp IS_BUSY ; ZERO = BUSY

IS_BUSY
	ADD R3, R3, #-1
	BRz END_BIT_COUNTER1
	ADD R1, R1, R1
	BRnzp CHECK_ADDR

END_BIT_COUNTER1
	ADD R2, R2, #1
	BRnzp END_BUSY_CHECK

NOT_BUSY
	ADD R2, R2, #0
END_BUSY_CHECK

;HINT Restore
LD R1, BACKUP_R1_3400
LD R3, BACKUP_R3_3400
LD R4, BACKUP_R4_3400
LD R7, BACKUP_R7_3400

RET
;--------------------------------
;Data for subroutine ALL_MACHINES_BUSY
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_BUSY .Fill xB400
BIT_COUNTER1					.FILL #16

BACKUP_R0_3400	.BLKW	#1
BACKUP_R1_3400	.BLKW	#1
BACKUP_R2_3400	.BLKW	#1
BACKUP_R3_3400	.BLKW	#1
BACKUP_R4_3400	.BLKW	#1
BACKUP_R5_3400	.BLKW	#1
BACKUP_R6_3400	.BLKW	#1
BACKUP_R7_3400	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: ALL_MACHINES_FREE (#2)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating whether all machines are free
; Return value (R2): 1 if all machines are free, 0 otherwise
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine ALL_MACHINES_FREE
;--------------------------------
;HINT back up 
.ORIG x3600
ST R1, BACKUP_R1_3600
ST R2, BACKUP_R2_3600
ST R3, BACKUP_R3_3600
ST R4, BACKUP_R4_3600 
ST R7, BACKUP_R7_3600

;R1 POINTER VAL
;R2 RET VAL
;R3 BIT_COUNTER
;R4 LD POINTER

AND R2, R2, #0
LD R4, BUSYNESS_ADDR_ALL_MACHINES_FREE
LDR R1, R4, #0
LD R3, BIT_COUNTER2

CHECK_ADDR_FREE
	ADD R1, R1, #0
	BRn IS_FREE ; ONE=FREE
	BRzp NOT_FREE ; ZERO = BUSY

IS_FREE
	ADD R3, R3, #-1
	BRz END_BIT_COUNTER2
	ADD R1, R1, R1
	BRnzp CHECK_ADDR_FREE

END_BIT_COUNTER2
	ADD R2, R2, #1
	BRnzp END_FREE_CHECK

NOT_FREE
	ADD R2, R2, #0
END_FREE_CHECK

;HINT Restore
LD R1, BACKUP_R1_3600
LD R3, BACKUP_R3_3600
LD R4, BACKUP_R4_3600
LD R7, BACKUP_R7_3600

RET
;--------------------------------
;Data for subroutine ALL_MACHINES_FREE
;--------------------------------
BUSYNESS_ADDR_ALL_MACHINES_FREE .Fill xB400
BIT_COUNTER2					.FILL #16

BACKUP_R0_3600	.BLKW	#1
BACKUP_R1_3600	.BLKW	#1
BACKUP_R2_3600	.BLKW	#1
BACKUP_R3_3600	.BLKW	#1
BACKUP_R4_3600	.BLKW	#1
BACKUP_R5_3600	.BLKW	#1
BACKUP_R6_3600	.BLKW	#1
BACKUP_R7_3600	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_BUSY_MACHINES (#3)
; Inputs: None
; Postcondition: The subroutine has returned the number of busy machines.
; Return Value (R1): The number of machines that are busy (0)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_BUSY_MACHINES
;--------------------------------
.ORIG x3800
;HINT back up 
;R1 0'S COUNTER
;R3 BIT_COUNTER

ST R1, BACKUP_R1_3800
ST R3, BACKUP_R3_3800
ST R4, BACKUP_R4_3800
ST R5, BACKUP_R5_3800
ST R7, BACKUP_R7_3800

LD R4, BUSYNESS_ADDR_NUM_BUSY_MACHINES
LDR R5, R4, #0

AND R1, R1, #0
LD R3, BIT_COUNTER3

BINARY_COUNT3
	ADD R5, R5, #0
	BRzp UP_COUNTER3
	ADD R5, R5, R5
	ADD R3, R3, #-1
	BRp BINARY_COUNT3
	BRz END_COUNT3
		
UP_COUNTER3
	ADD R1, R1, #1
	ADD R5, R5, R5
	ADD R3, R3, #-1
	BRp BINARY_COUNT3

END_COUNT3

LD R3, BACKUP_R3_3800
LD R4, BACKUP_R4_3800
LD R5, BACKUP_R5_3800
LD R7, BACKUP_R7_3800
;HINT Restore

RET
;--------------------------------
;Data for subroutine NUM_BUSY_MACHINES
;--------------------------------
BUSYNESS_ADDR_NUM_BUSY_MACHINES .Fill xB400
BIT_COUNTER3	.FILL	#16

BACKUP_R0_3800	.BLKW	#1
BACKUP_R1_3800	.BLKW	#1
BACKUP_R2_3800	.BLKW	#1
BACKUP_R3_3800	.BLKW	#1
BACKUP_R4_3800	.BLKW	#1
BACKUP_R5_3800	.BLKW	#1
BACKUP_R6_3800	.BLKW	#1
BACKUP_R7_3800	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: NUM_FREE_MACHINES (#4)
; Inputs: None
; Postcondition: The subroutine has returned the number of free machines
; Return Value (R1): The number of machines that are free (1)
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine NUM_FREE_MACHINES
;--------------------------------
.ORIG x4000
;HINT back up 

;R1 0'S COUNTER
;R3 BIT_COUNTER

ST R1, BACKUP_R1_4000
ST R3, BACKUP_R3_4000
ST R4, BACKUP_R4_4000
ST R5, BACKUP_R5_4000
ST R7, BACKUP_R7_4000

LD R4, BUSYNESS_ADDR_NUM_FREE_MACHINES
LDR R5, R4, #0

AND R1, R1, #0
LD R3, BIT_COUNTER4

BINARY_COUNT4
	ADD R5, R5, #0
	BRn UP_COUNTER4
	ADD R5, R5, R5
	ADD R3, R3, #-1
	BRp BINARY_COUNT4
	BRz END_COUNT4
		
UP_COUNTER4
	ADD R1, R1, #1
	ADD R5, R5, R5
	ADD R3, R3, #-1
	BRp BINARY_COUNT4

END_COUNT4

LD R3, BACKUP_R3_4000
LD R4, BACKUP_R4_4000
LD R5, BACKUP_R5_4000
LD R7, BACKUP_R7_4000
;HINT Restore
RET
;--------------------------------
;Data for subroutine NUM_FREE_MACHINES 
;--------------------------------
BUSYNESS_ADDR_NUM_FREE_MACHINES .Fill xB400
BIT_COUNTER4	.FILL	#16

BACKUP_R0_4000	.BLKW	#1
BACKUP_R1_4000	.BLKW	#1
BACKUP_R2_4000	.BLKW	#1
BACKUP_R3_4000	.BLKW	#1
BACKUP_R4_4000	.BLKW	#1
BACKUP_R5_4000	.BLKW	#1
BACKUP_R6_4000	.BLKW	#1
BACKUP_R7_4000	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: MACHINE_STATUS (#5)
; Input (R1): Which machine to check, guaranteed in range {0,15}
; Postcondition: The subroutine has returned a value indicating whether
;                the selected machine (R1) is busy or not.
; Return Value (R2): 0 if machine (R1) is busy, 1 if it is free
;              (R1) unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine MACHINE_STATUS
;--------------------------------
.ORIG x4200
;HINT back up 
ST R1, BACKUP_R1_4200
ST R2, BACKUP_R2_4200
ST R3, BACKUP_R3_4200
ST R4, BACKUP_R4_4200
ST R5, BACKUP_R5_4200
ST R6, BACKUP_R6_4200
ST R7, BACKUP_R7_4200

;R1 MACHINE STORED HERE
;R2 RETURN IF BUSY OR NOT
;R3 BIT COUNTER
;R4 VALUE STORED
;R5 VALUE POINTER

LD R5, BUSYNESS_ADDR_MACHINE_STATUS
LDR R4, R5, #0
AND R2, R2, #0
LD R3, BIT_COUNTER5
NOT R1, R1
ADD R1, R1, #1
ADD R3, R3, R1
BRz FINAL_CHECK_5

CHECK_BIT_LOOP
	ADD R4, R4, R4
	ADD R3, R3, #-1
	BRp CHECK_BIT_LOOP

FINAL_CHECK_5
	ADD R4, R4, #0
	BRn END_SUB5
	ADD R2, R2, #1

END_SUB5

;HINT Restore
LD R1, BACKUP_R1_4200
;LD R2, BACKUP_R2_4200
LD R3, BACKUP_R3_4200
LD R4, BACKUP_R4_4200
LD R5, BACKUP_R5_4200
LD R6, BACKUP_R6_4200
LD R7, BACKUP_R7_4200
RET
;--------------------------------
;Data for subroutine MACHINE_STATUS
;--------------------------------
BUSYNESS_ADDR_MACHINE_STATUS	.Fill xB400
BIT_COUNTER5		.FILL		#15

BACKUP_R0_4200	.BLKW	#1
BACKUP_R1_4200	.BLKW	#1
BACKUP_R2_4200	.BLKW	#1
BACKUP_R3_4200	.BLKW	#1
BACKUP_R4_4200	.BLKW	#1
BACKUP_R5_4200	.BLKW	#1
BACKUP_R6_4200	.BLKW	#1
BACKUP_R7_4200	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: FIRST_FREE (#6)
; Inputs: None
; Postcondition: The subroutine has returned a value indicating the lowest numbered free machine
; Return Value (R1): the number of the free machine
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine FIRST_FREE
;--------------------------------
.ORIG x4400
;HINT back up 
ST R1, BACKUP_R1_4400
ST R2, BACKUP_R2_4400
ST R3, BACKUP_R3_4400
ST R4, BACKUP_R4_4400
ST R5, BACKUP_R5_4400
ST R6, BACKUP_R6_4400
ST R7, BACKUP_R7_4400

LD R6, BUSYNESS_ADDR_FIRST_FREE
LDR R2, R6, #0
LD R3, MACHINE_LOC
LD R1, NEG_ONE

FIRST_FREE_LOOP
	ADD R2, R2, #0
	BRn IDENTIFIED_FREE
	BRnzp UPDATE_R2
		
IDENTIFIED_FREE
	ADD R1, R3, #0

UPDATE_R2
	ADD R2, R2, R2
	ADD R3, R3, #-1
	BRzp FIRST_FREE_LOOP

END_FIRST_FREE

;HINT Restore
;LD R1, BACKUP_R1_4400
LD R2, BACKUP_R2_4400
LD R3, BACKUP_R3_4400
LD R4, BACKUP_R4_4400
LD R5, BACKUP_R5_4400
LD R6, BACKUP_R6_4400
LD R7, BACKUP_R7_4400
RET
;--------------------------------
;Data for subroutine FIRST_FREE
;--------------------------------
BUSYNESS_ADDR_FIRST_FREE .Fill xB400
MACHINE_LOC				.FILL	#15
NEG_ONE					.FILL	#-1

BACKUP_R0_4400	.BLKW	#1
BACKUP_R1_4400	.BLKW	#1
BACKUP_R2_4400	.BLKW	#1
BACKUP_R3_4400	.BLKW	#1
BACKUP_R4_4400	.BLKW	#1
BACKUP_R5_4400	.BLKW	#1
BACKUP_R6_4400	.BLKW	#1
BACKUP_R7_4400	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: GET_MACHINE_NUM
; Inputs: None
; Postcondition: The number entered by the user at the keyboard has been converted into binary,
;                and stored in R1. The number has been validated to be in the range {0,15}
; Return Value (R1): The binary equivalent of the numeric keyboard entry
; NOTE: You can use your code from assignment 4 for this subroutine, changing the prompt, 
;       and with the addition of validation to restrict acceptable values to the range {0,15}
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x4600

ST R1, BACKUP_R1_4600
ST R2, BACKUP_R2_4600
ST R3, BACKUP_R3_4600
ST R4, BACKUP_R4_4600
ST R5, BACKUP_R5_4600
ST R6, BACKUP_R6_4600
ST R7, BACKUP_R7_4600

START_OF_PROGRAM

LEA R0, prompt
PUTS
						
; Set up flags, counters, accumulators as needed
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0
AND R5, R5, #0
AND R6, R6, #0

LD R3, COUNTER

GET_DIGITS					
	GETC
	OUT
		
	LD R1, ENDL_OFFSET	
	ADD R2, R0, R1
	BRz CHECK_FIRST_CHAR

	LD R1, ZERO		
	ADD R2, R0, R1
	BRn NEED_ENDL

	LD R1, NINE				
	ADD R2, R0, R1
	BRp NEED_ENDL	
		
	ADD R3, R3, #-1
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
	ADD R3, R3, #0
	BRp GET_DIGITS
	ADD R3, R3, #0
	BRz CHECK_FIRST_CHAR

NEED_ENDL
	LD R0, ENDLINE
	OUT
ERROR_MSG
	LEA R0, Error_msg_2
	PUTS
	BRnzp START_OF_PROGRAM

CHECK_FIRST_CHAR
	ADD R4, R3, #-5
	BRz EXTRA_ENDLINE
	ADD R3, R3, #0
	BRnp END_OF_PROGRAM
	
FINAL_PART
	LD R0, ENDLINE			; remember to end with a newline!
	OUT

END_OF_PROGRAM

AND R1, R1, #0
ADD R1, R5, #0
BRn ERROR_MSG
ADD R3, R5, #-15
BRp EXTRA_ENDLINE
BRnzp END_INPUT_SUB

EXTRA_ENDLINE
	LD R0, ENDLINE
	OUT
	BRnzp ERROR_MSG

END_INPUT_SUB

LD R2, BACKUP_R2_4600
LD R3, BACKUP_R3_4600
LD R4, BACKUP_R4_4600
LD R5, BACKUP_R5_4600
LD R6, BACKUP_R6_4600
LD R7, BACKUP_R7_4600

RET
;--------------------------------
;Data for subroutine Get input
;--------------------------------
prompt .STRINGZ "Enter which machine you want the status of (0 - 15), followed by ENTER: "
Error_msg_2 .STRINGZ "ERROR INVALID INPUT\n"

ZERO				.FILL	#-48
NINE				.FILL	#-57
MINUS				.FILL	#-45
ADDITION			.FILL	#-43
ENDL_OFFSET			.FILL	#-10
ENDLINE				.FILL	'\n'
COUNTER				.FILL	#5
TEN_COUNT			.FILL	#9

BACKUP_R0_4600	.BLKW	#1
BACKUP_R1_4600	.BLKW	#1
BACKUP_R2_4600	.BLKW	#1
BACKUP_R3_4600	.BLKW	#1
BACKUP_R4_4600	.BLKW	#1
BACKUP_R5_4600	.BLKW	#1
BACKUP_R6_4600	.BLKW	#1
BACKUP_R7_4600	.BLKW	#1

;-----------------------------------------------------------------------------------------------------------------
; Subroutine: PRINT_NUM
; Inputs: R1, which is guaranteed to be in range {0,16}
; Postcondition: The subroutine has output the number in R1 as a decimal ascii string, 
;                WITHOUT leading 0's, a leading sign, or a trailing newline.
; Return Value: None; the value in R1 is unchanged
;-----------------------------------------------------------------------------------------------------------------
;-------------------------------
;INSERT CODE For Subroutine 
;--------------------------------
.ORIG x4800

ST R1, BACKUP_R1_4800
ST R2, BACKUP_R2_4800
ST R3, BACKUP_R3_4800
ST R4, BACKUP_R4_4800
ST R5, BACKUP_R5_4800
ST R6, BACKUP_R6_4800
ST R7, BACKUP_R7_4800

;R1 WHERE VALUE IS STORED
;R2 OFFSET_NUM
;R3 TEMP HOLDER CHECK
;R4 OUTPUT NUM COUNTER
;R5 DIGIT COUNTER
;R6 DEC_HOLDER_OFFSET

LD R2, NUM_OFFSET
AND R4, R4, #0
LD R5, DIGIT_COUNTER


;check number of digits in number
LD_DIGIT_TEST
	LD R6, TENK
	ADD R3, R1, R6
	BRzp TEST_TENK
	ADD R5, R5, #-1
	LD R6, ONEK
	ADD R3, R1, R6
	BRzp TEST_ONEK
	ADD R5, R5, #-1
	LD R6, HUNDRED
	ADD R3, R1, R6
	BRzp TEST_HUNDRED
ADD R5, R5, #-1
LD R6, TEN
ADD R3, R1, R6
BRzp TEST_TENS
BRnzp TEST_ONES

;check whether there are 0's 
TEST_TENK
	BRn TEST_ONEK
	LD R6, TENK
	ADD R3, R1, R6
	BRzp TEMP_R3
	ADD R5, R5, #-1
TEST_ONEK
	ADD R3, R5, #-4
	BRn TEST_HUNDRED
	LD R6, ONEK
	ADD R3, R1, R6
	BRnzp TEMP_R3
TEST_HUNDRED
	ADD R3, R5, #-3
	BRn TEST_TENS
	LD R6, HUNDRED
	ADD R3, R1, R6
	BRnzp TEMP_R3
TEST_TENS
	ADD R3, R5, #-2
	BRn TEST_ONES
	LD R6, TEN
	ADD R3, R1, R6
	BRnzp TEMP_R3
TEST_ONES
	ADD R0, R1, R2
	OUT
BRnzp END_CHECK


;divide number by each placeholder
TEMP_R3
	ADD R3, R1, #0
DIVIDER
	ADD R4, R4, #1
	ADD R3, R3, R6
	BRzp DIVIDER
;output the value
OUTPUTTER
	ADD R4, R4, #-1
	ADD R0, R4, R2
	OUT
	ADD R5, R5, #-1
	ADD R4, R4, #0
	BRz TEST_ONEK
	AND R3, R3, #0
;update r1 by value subtracted
UPDATE_R1
	ADD R3, R3, R6
	ADD R4, R4, #-1
	BRp UPDATE_R1
	ADD R1, R1, R3
	BRnzp TEST_ONEK
	
END_CHECK

LD R1, BACKUP_R1_4800
LD R2, BACKUP_R2_4800
LD R3, BACKUP_R3_4800
LD R4, BACKUP_R4_4800
LD R5, BACKUP_R5_4800
LD R6, BACKUP_R6_4800
LD R7, BACKUP_R7_4800


RET
;--------------------------------
;Data for subroutine print number
;--------------------------------
NUM_OFFSET		.FILL	#48
MINUS_SIGN		.FILL	'-'
TENK			.FILL	#-10000
ONEK			.FILL	#-1000
HUNDRED			.FILL	#-100
TEN				.FILL	#-10
DIGIT_COUNTER	.FILL	#5

BACKUP_R0_4800	.BLKW	#1
BACKUP_R1_4800	.BLKW	#1
BACKUP_R2_4800	.BLKW	#1
BACKUP_R3_4800	.BLKW	#1
BACKUP_R4_4800	.BLKW	#1
BACKUP_R5_4800	.BLKW	#1
BACKUP_R6_4800	.BLKW	#1
BACKUP_R7_4800	.BLKW	#1


;---------------------------------
;END DATA
;---------------------------------

.ORIG x5000
MENUSTRING .STRINGZ "**********************\n* The Busyness Server *\n**********************\n1. Check to see whether all machines are busy\n2. Check to see whether all machines are free\n3. Report the number of busy machines\n4. Report the number of free machines\n5. Report the status of machine n\n6. Report the number of the first available machine\n7. Quit\n"

.ORIG xB400			; Remote data
BUSYNESS .FILL x0000		; <----!!!BUSYNESS VECTOR!!! Change this value to test your program.

;---------------	
;END of PROGRAM
;---------------	
.END
