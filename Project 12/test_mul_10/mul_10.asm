;******************************************************************************
; Filename:    swap_values.asm
; Author:      
; Description: main application for Project 12
;******************************************************************************
	.ORIG x0200

  ; Set a break point at each call to MUL_10.  Verify that the  value returned in
  ; R0 is 10x the number passed in.
  
  LD    R0, NUM1 
  JSR   MUL_10
  
  LD    R0, NUM2 
  JSR   MUL_10
  
  LD    R0, NUM3 
  JSR   MUL_10

DONE  BR DONE

NUM1  .FILL 200
NUM2  .FILL 99
NUM3  .FILL 6

;******************************************************************************
; Subroutine        :   MUL_10
; Description       :   Multiplies the value in R0 by 10
; Input             :   R0 = Value to multiply
; Output            :   R0 = Return Value
;******************************************************************************
MUL_10
	ST R2, MULR2	;Save R2
	ST R4, MULR4	;Save R4
	AND R2, R2, #0 	;Clear R2
	LD R4, TENVAR	;sets R4 to the constant 10
MULLOOP	ADD R2, R2, R0	;ADD R0 to R2
	ADD R4, R4, #-1	;decrement R4
	BRp MULLOOP	;return to loop if R4 > 0
	ADD R0, R2, #0	;Sets R0 to the value in R2
	LD R2, MULR2	;Load R2
	LD R4, MULR4	;Load R4
	RET	;returns

MULR2 .FILL 0	;space for r2
MULR4 .FILL 0	;space for r4
TENVAR .FILL #10	;consant 10 used for multiplication by 10
    .END