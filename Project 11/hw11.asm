;******************************************************************************
; Filename:    hw11.asm
; Author:      WillDaru22
; Description: Test Code for Median of List subroutines
;******************************************************************************
	.ORIG x0200
START    
	; set initial register values to make it easier to see if
	; they are changed by the subroutine
	LD R0, INITR0
	ADD R1, R0, #1
	ADD R2, R0, #2
	ADD R3, R0, #3
	ADD R4, R0, #4
	ADD R5, R0, #5
	ADD R6, R0, #6
	ADD R7, R0, #7

	; run first test
	LEA R0, Data1
	LD	R1, Length1
	JSR Median

	; run remaining tests
	; figure out what each call should return, and verify that it does

	LEA R0, Data2
	LD 	R1, Length2
	JSR Median

	BR START		; repeat subroutine tests
INITR0 	.FILL 0
Length1 .FILL 5
Data1 	.FILL 33
		.FILL -35
		.FILL 97
		.FILL 11
		.FILL -60
Length2 .FILL 11
Data2	.FILL -73
		.FILL -33
		.FILL -10
		.FILL 31
		.FILL 5
		.FILL -59
		.FILL 28
		.FILL -64
		.FILL -45
		.FILL -46
		.FILL 87

;******************************************************************************
; Subroutine:  Median
; Description: Brute force search for the median of a list of numbers.  Passed
;              the starting address of list in R0, and the length of the list
;              in R1 it searches the numbers in the list till it finds the median.
;              Makes a call to Cnt_GTE for each number searched.  If cnt_GTE 
;              returns a number equal to the length of the list (R1) then the 
;              median is the last number searched and the search terminates and
;			   return the median in R3.
;
; Assumptions:	R1 - length of list is non-zero odd number.
;
; Assumes      R0 - starting address for list
;              R1 - The length of the list (has to be an odd number)
; Returns      R2 - The median of the list
;******************************************************************************
Median
	; YOUR CODE GOES BELOW HERE
	ST R1, Median_SAVER1	;store R1
	ST R4, Median_SAVER4	;store R4
	ST R7, Median_SAVER7	;store R7
	NOT R1, R1	;Negate R1 so we can compare it
	ADD R1, R1, #1	;completing negation
MEDLOOP	JSR Cnt_GTE	;Calls Cnt_GTE with wherever we are in the list
	ADD R3, R3, R1	;subtracts the length of the list from the count we got from Cnt_GTE
	BRz MED_EXIT	;Exits the loop if the length equals the count
	ADD R0, R0, #1	;increments R0 to look at the next number in the list
	BRnzp MEDLOOP	;returns to the start of the loop
MED_EXIT LDR R2, R0, #0	;loads the current value from the address in R0 into R2
	LD R1, Median_SAVER1	;restore R1
	LD R4, Median_SAVER4	;restore R4
	LD R7, Median_SAVER7	;restore R7
	RET
Median_SAVER1 .FILL 0	;space to save R1
Median_SAVER4 .FILL 0	;space to save R4
Median_SAVER7 .FILL 0	;space to save R7
	; YOUR CODE GOES ABOVE HERE


;******************************************************************************
; Subroutine:  Cnt_GTE
; Description: Used to help calculate median of a list.  A "search" number is
;              passed in via R2.  The starting address of a list is passed via R0
;              and the length of the list is passed via R1.  The list is read one
;              number at a time.  If the number is greater than the "search" (R2)
;              number the count is incremented by 2.  If the number is equal to
;              the search number the count is incremented by 1. 
; 
; Assumes      R0 - starting address for list
;              R1 - length of the list
;              R2 - search number
; Returns      R3 - Count
;******************************************************************************
Cnt_GTE
	; YOUR CODE GOES BELOW HERE
	ST R0, Cnt_SAVER0	;Save R0
	ST R1, Cnt_SAVER1	;Save R1
	ST R2, Cnt_SAVER2	;Save R2
	ST R4, Cnt_SAVER4	;Save R4
	ST R5, Cnt_SAVER5	;Save R5
	ST R6, Cnt_SAVER6	;Save R6
	NOT R2, R2	;negate search number so we can subtract it
	ADD R2, R2, #1	;completing negation
	AND R3, R3, #0	;sets R3, our count, to 0 at the start of the subroutine
	AND R6, R6, #0	;sets R6 to be our tracker for where we are in the list, starting at 0
LISTLOOP LDR R4, R0, #0	;Get current number in list (start of loop)
	ADD R4, R4, R2	;subtract the search number from the current number in list
	BRp	TWOCOUNT	;Branch if greater than search number
	BRz ONECOUNT	;Branch if equal to search number
	ADD R6, R6, #1	;increments tracker for where we are in the list
	ADD R5, R1, R6	;checks if our tracker has reached the end of the list
	BRzp Cnt_GTE_EXIT	;exits to end if reached the end of the list
	ADD R0, R0, #1	;Adds increments R0 if we havent reached the end of the list
	BRnzp LISTLOOP		;Return to start of loop
	
TWOCOUNT
	ADD R3, R3, #2	;increment count by 2
	ADD R6, R6, #1	;increments tracker for where we are in the list
	ADD R5, R6, R1	;checks if our tracker has reached the end of the list
	BRzp Cnt_GTE_EXIT	;exits to end if reached the end of the list
	ADD R0, R0, #1	;Adds increments R0 if we havent reached the end of the list
	BRnzp LISTLOOP	;if tracker is less than list length, go bacak to loop
	
ONECOUNT
	ADD R3, R3, #1	;increment count by 1
	ADD R6, R6, #1	;increments tracker for where we are in the list
	ADD R5, R6, R1	;checks if our tracker has reached the end of the list
	BRzp Cnt_GTE_EXIT	;exits to end if reached the end of the list
	ADD R0, R0, #1	;Adds increments R0 if we havent reached the end of the list
	BRnzp LISTLOOP	;if tracker is less than list length, go bacak to loop
	
Cnt_GTE_EXIT
	LD R0, Cnt_SAVER0	;restore R0
	LD R1, Cnt_SAVER1	;restore R1
	LD R2, Cnt_SAVER2	;restore R2
	LD R4, Cnt_SAVER4	;restore R4
	LD R5, Cnt_SAVER5	;restore R5
	LD R6, Cnt_SAVER6	;restore R6
	RET

Cnt_SAVER0 .FILL 0	;reserve space to save R0	
Cnt_SAVER1 .FILL 0	;reserve space to save R1
Cnt_SAVER2 .FILL 0	;reserve space to save R2
Cnt_SAVER4 .FILL 0	;reserve space to save R4
Cnt_SAVER5 .FILL 0	;reserve space to save R5
Cnt_SAVER6 .FILL 0	;reserve space to save R6
	; YOUR CODE GOES ABOVE HERE

	.END

