; Filename:    hw09.asm
; Author:      WillDaru22
;              
; Description: implements the homework 09 flowchart
;              that includes two condition tests

	.ORIG x0200
START
	; YOUR CODE GOES BELOW HERE
	LD R3, K	;Load value of K into register 3
	NOT R1, R3	;Negate K so that we can compare it to L and store it in R1 so we can reuse the value of K later
	ADD R1, R1, #1	;Add 1 to finish negation
	LD R4, L	;Load value of L into register 4
	ADD R0, R4, R1	;Add L to the negative K, storing to R0 so we can reuse the value of L later
	BRp KSMALLER	;If the result is positive K is less than L
	BRn KLARGER	;If the result is negative K is greater than L
	LD R5, M	;Executes if K=L, Loads value of M to register 5
	ST R5, N	;Stores M into label N in memory
KSMALLER	;Label to denote that branch is taken when K is smaller than L
	ST R4, J	;Stores L into label J in memory
	BR DONE		;Finished, jump to end
KLARGER		;Label to denote that branch is taken when K is larger than L
	ST R3, M	;Stores K into label M in memory then goes to the end

	; YOUR CODE GOES ABOVE HERE

DONE	BR  START

 ; Program Data

J   .FILL #10
K   .FILL #8
L   .FILL #6
M   .FILL #4
N   .FILL #2

	.END