;******************************************************************************
; Filename:    hw12.asm
; Author:      
; Description: main application for Project 12
;******************************************************************************
	.ORIG x0200

START

	; ***********
	; Set a break point at the LEA instruction.  You should see the contents of memory
	; match the .FILL values below.
	; ***********
	
    LEA   R0, ARRAY_1
    JSR   BUBBLE_SORT
	
	; ***********
	; Set a break point at the DONE label.  Examine the memory at ARRAY_1 and
	; validate that it was sorted correctly
	; ***********

DONE  BR DONE

ARRAY_1   .FILL   10
          .FILL    0
          .FILL   23 
          .FILL   100 
          .FILL   511
          .FILL   33
          .FILL   223
          .FILL   464
          .FILL   252
          .FILL    17


;******************************************************************************
; Subroutine    :   BUBBLE_SORT
; Description   :   Given an unsorted array of size 10, this function will use 
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
BUBBLE_SORT  ;Runs in worst case every time (O(N*N)
	ST R0, BUBBLER0 ;save R0
   	ST R4, BUBBLER4	;save R4
	ST R7, BUBBLER7	;save R7
	LD R5, BUBBLETEN	;set R5 to constant 10
BUBBLELOOPOUT LEA R0, ARRAY_1	;resets R0 to point to start of array
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
;                   number at the lower memory address is greaeter than the 
;                   number at the higher memory address, the location of the 
;                   numbers are swapped and the function returns. 
;                   
;                   If the value at the lower memory address is smaller or 
;                   equal to the value at the higher memory address, then the 
;                   function does not modify the array an returns.
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
    .END

