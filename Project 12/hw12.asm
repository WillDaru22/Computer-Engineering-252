;******************************************************************************
; Filename:    hw12.asm
; Author:      WillDaru22
; Description: main application for Project 12
;******************************************************************************

;************************************
; DO NOT MODIFY ZONE START
;************************************
	.ORIG x3000

    LEA R0, PROMPT1
    PUTS
    LEA R0, NUM_ARRAY_1
    JSR GET_ARRAY

   
    LEA R0, PROMPT2
    PUTS
    LEA R0, NUM_ARRAY_2
    JSR GET_ARRAY
	
BREAK_POINT_1
	  LEA R0, NUM_ARRAY_1
	  JSR BUBBLE_SORT
    LEA R0, NUM_ARRAY_2
    JSR BUBBLE_SORT

DONE  BR DONE

;************************************
; DO NOT MODIFY ZONE END
;************************************

NUM_ARRAY_1   .BLKW   10
NUM_ARRAY_2   .BLKW   10
STUDENT1_NAME  .STRINGZ "William Wilson\n"
STUDENT2_NAME  .STRINGZ "WORKING ALONE\n"
PROMPT1       .STRINGZ "\nEneter Array 1"
PROMPT2       .STRINGZ "\nEneter Array 2"

;******************************************************************************
; Subroutine    :   GET_ARRAY  
; Description   :   Stores 10 numbers entered by the user into an array starting
;                   at the address specified in R0.  You will call GET_INPUT
;                   10 times and store the results into the array
; Input(s)      :   R0 is the base address of the array
; Outputs(s)    :   None
;******************************************************************************
GET_ARRAY	;some bugs exist
	ST R0, ARRAYR0	;save R0
	ST R1, ARRAYR1	;save R1
	ST R6, ARRAYR6	;save R6
	ST R7, ARRAYR7	;save R7
	ADD R1, R0, #0	;sets R1 to R0 since we are going to corrupt R0
	LD R6, BUBBLETEN	;sets R6 to the constant 10 for use in array iteration
ARRAYLOOP JSR GET_INPUT	;call to get_input
	STR R0, R1, #0	;stores the input into the array at the current spot
	ADD R1, R1, #1	;increments R1 so we are pointing at the next empty spot in the array
	ADD R6, R6, #-1	;decrement R6
	BRp ARRAYLOOP	;go back into the loop if R6>0
	LD R0, ARRAYR0	;load R0
	LD R1, ARRAYR1	;load R1
	LD R6, ARRAYR6	;load R6
	LD R7, ARRAYR7	;load R7
    RET
ARRAYR0 .FILL 0 ;space to save R0
ARRAYR1 .FILL 0	;space to save R1
ARRAYR6 .FILL 0	;space to save R6
ARRAYR7 .FILL 0 ;space to save R7
;******************************************************************************
; Subroutine    :   BUBBLE_SORT
; Description   :   Given an unsorted array of size 10, this subroutine will use 
;                   the bubble sort algorithm to sort the array from smallest
;                   to largest values.  Assume that all of the values are 
;                   in the range of 0 to 999.  You do not need to verify any
;                   of the values.
;
;                   If you are not familiar with what bubble sort is, read the
;                   wikipedia article about it.
;
; Input(s)      :   R0 is the base address of the array
; Outputs(s)    :   None
;******************************************************************************
BUBBLE_SORT  ;Runs in worst case every time (O(N*N)), will optomize if I have time
	ST R0, BUBBLER0 ;save R0
   	ST R4, BUBBLER4	;save R4
	ST R7, BUBBLER7	;save R7
	LD R5, BUBBLETEN	;set R5 to constant 10
BUBBLELOOPOUT LD R0, BUBBLER0	;resets R0 to point to start of array
	LD R4, BUBBLETEN	;set R4 to constant 10
BUBBLELOOPIN JSR SWAP_VALUES	;call to swap values
	ADD R0, R0, #1	;increment R0 to point to next spot in array
	ADD R4, R4, #-1	;decrement R4
	BRp BUBBLELOOPIN	;return to loop if R4>0
	ADD R5, R5, #-1 ;decrement R5
	BRp BUBBLELOOPOUT	;returns to outer loop if R5>0
	LD R0, BUBBLER0	;load R0
   	LD R4, BUBBLER4	;load R4
	LD R7, BUBBLER7	;load R7
  RET 
BUBBLETEN .FILL 10	;sets to constant 10
BUBBLER0 .FILL 0	;space to save R0
BUBBLER4 .FILL 0	;space to save R4
BUBBLER5 .FILL 0	;space to save R5
BUBBLER7 .FILL 0	;space to save R7

;******************************************************************************
; Subroutine    :  SWAP_VALUES
; Description   :   Examines two consecutive locations in memory.  If the 
;                   number at the lower memory address is greater than the 
;                   number at the higher memory address, the numbers are 
;                   swapped and the subroutine returns. 
;                   
;                   If the value at the lower memory address is smaller or 
;                   equal to the value at the higher memory address, then the 
;                   subroutine does not modify the array and returns.
;
; Input(s)      :   R0 is the base address of the array
; Outputs(s)    :   None
;******************************************************************************
SWAP_VALUES
	ST R7, SWAPR7	;Save R7
	ST R1, SWAPR1	;Save R1
	ST R2, SWAPR2	;Save R2
	ST R3, SWAPR3	;Save R3
	LDR R1, R0, #0	;Get value at lower mem address
	LDR R2, R0, #1	;Get value at higher mem address
	NOT R3, R1	;negate R1
	ADD R3, R3, #1	;complete negation
	ADD R3, R3, R2	;Add higher mem address value
	BRzp SWAP_EXIT	;exit if lower mem address value is equal to or less than higher mem address value
	LDR R3, R0, #1	;get value at higher mem address
	STR R1, R0, #1	;store value at lower mem address to higher mem address
	STR R3, R0, #0	;store value at higher mem address to lower mem address
SWAP_EXIT LD R1, SWAPR1	;Load R1
	LD R2, SWAPR2	;Load R2
	LD R3, SWAPR3	;Load R3
	LD R7, SWAPR7	;Load R7
  RET
SWAPR1 .FILL 0	;space to save R1
SWAPR2 .FILL 0	;space to save R2
SWAPR3 .FILL 0	;space to save R3
SWAPR7 .FILL 0	;space to save R7

;******************************************************************************
; Subroutine:   :   GET_INPUT 
; Description   :   Prints a message to the user to input a 3-digit number.  The
;                   3 digit ASCII string is converted to a decimal number and is 
;                   returned in R0. 
;
;                   You will use the capabilities of the LC3 OS to accept 
;                   ASCII characters, one character at a time, from the keyboard.
;                   The value is returned when 3 digits have been received OR
;                   the user presses the ENTER key. Be sure to echo each character
;                   received back to the user so they can see the number they enter.
;
;                   You can assume that all characters entered are ASCII 
;                   characters in the range of 0x30-0x39.  
;                   
;                   A user input of "239" would be converted to :
;                   (0x32 - 0x30) * 100 + (0x33-0x30)*10 + (0x39-0x30) = 239
;          
; Example Inputs
;                   Enter a 3-digit number      :<ENTER>     ; Returns 0
;                   Enter a 3-digit number      :1<ENTER>    ; Returns 1
;                   Enter a 3-digit number      :91<ENTER>   ; Returns 91
;                   Enter a 3-digit number      :456         ; Returns 456
;
; Input(s)      :   None
; Outputs(s)    :   R0 is used to return the decimal value the user input 
;******************************************************************************
GET_INPUT	;weird bug with storing BR instructions instead of values.  No idea how to fix
	ST R1, INPR1	;Save R1
	ST R2, MULR2	;Save R2 (reusing space in memory)
	ST R4, MULR4	;Save R4 (reusing space in memory)
	ST R7, INPR7	;Save R7
	LEA R2, NUM_ARRAY_1	;loads array to store numbers
	LEA R0, PROMPTS	;get memory address to print to console
	LD R4, THREEVAR	;Set R4 to the constant 3
	PUTS	;Print to console
INPLOOP	GETC
	ADD R1, R0, #-10	;checks if <ENTER> was input
	BRz	GET_INPUT_EXIT	;exits loop if <ENTER> was input
	STR	R0, R2, #0	;stores number in array
	ADD R2, R2, #1	;increments R2 so we point to open space
	OUT	;echo input to user
	ADD R4, R4, #-1	;decrements R4
	BRnz	GET_INPUT_EXIT	;exits loop if 3 digits entered
	BRnzp INPLOOP	;back into loop
GET_INPUT_EXIT
	LEA R2, NUM_ARRAY_1	;get array with our inputs
	LDR R0, R2, #0	;load first value in array
	ADD R0, R0, #-16	;subtract 16 three times to get decimal value
	ADD R0, R0, #-16	;subtract 16 three times to get decimal value
	ADD R0, R0, #-16	;subtract 16 three times to get decimal value
	JSR MUL_10	;multiply by 10
	JSR MUL_10	;multiply by 10
	ADD R1, R0, #0	;Save our times 100 value
	LDR R0, R2, #1	;load 2nd value in array
	ADD R0, R0, #-16	;subtract 16 three times to get decimal value
	ADD R0, R0, #-16	;subtract 16 three times to get decimal value
	ADD R0, R0, #-16	;subtract 16 three times to get decimal value
	JSR MUL_10	;multiply by 10
	ADD R1, R1, R0	;Add our time 10 value to R1
	LDR R0, R2, #2	;Load our 3rd value in array
	ADD R0, R0, #-16	;subtract 16 three times to get decimal value
	ADD R0, R0, #-16	;subtract 16 three times to get decimal value
	ADD R0, R0, #-16	;subtract 16 three times to get decimal value
	ADD R0, R0, R1	;Add R1 which has our *100+*10 values to R0.
	LD R1, INPR1	;Load R1
	LD R2, MULR2	;Load R2
	LD R4, MULR4	;Load R4
	LD R7, INPR7	;Load R7
	RET	;returns
INPR1 .FILL 0	;space to save R1
INPR7 .FILL 0	;space to save R7
THREEVAR .FILL #3	;constant 3 used to check if 3 digits entered
PROMPTS   .STRINGZ "Enter a 3-digit number      :"
	
;******************************************************************************
; Subroutine        :   MUL_10
; Description       :   Multiplies the value in R0 by 10
; Input             :   R0 = Value to multiply
; Output            :   R0 = Return Value
;******************************************************************************
MUL_10
	ST R2, MULR2	;Save R2
	ST R4, MULR4	;Save R4
	ST R7, MULR7	;Save R7
	AND R2, R2, #0 	;Clear R2
	LD R4, TENVAR	;sets R4 to the constant 10
MULLOOP	ADD R2, R2, R0	;ADD R0 to R2
	ADD R4, R4, #-1	;decrement R4
	BRp MULLOOP	;return to loop if R4 > 0
	ADD R0, R2, #0	;Sets R0 to the value in R2
	LD R2, MULR2	;Load R2
	LD R4, MULR4	;Load R4
	LD R7, MULR7	;Load R7
	RET	;returns

MULR2 .FILL 0	;space for r2
MULR4 .FILL 0	;space for r4
MULR7 .FILL 0	;space for r7
TENVAR .FILL #16	;consant 16 used for multiplication by 10 due to decimal vs hex
    .END

