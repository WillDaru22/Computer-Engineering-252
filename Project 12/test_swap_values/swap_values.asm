;******************************************************************************
; Filename:    swap_values.asm
; Author:      
; Description: main application for Project 12
;******************************************************************************
	.ORIG x0200

  ; Set a break point at each call to SWAP_VALUES.  Verify that after the call,
  ; the values are swapped if the lower memory address is larger than the higher
  ; memory address.
  
  LEA   R0, ARRAY1
  JSR   SWAP_VALUES

  LEA   R0, ARRAY2
  JSR   SWAP_VALUES

  LEA   R0, ARRAY3
  JSR   SWAP_VALUES

DONE  BR DONE

ARRAY1 .FILL   100
       .FILL   200
ARRAY2 .FILL   99
       .FILL   2
ARRAY3 .FILL   50
       .FILL   50

;******************************************************************************
; Subroutine    :  SWAP_VALUES
; Description   :   Examines two consecutive locations in memory.  If the 
;                   number at the lower memory address is greater than the 
;                   number at the higher memory address, the numbers are 
;                   swapped and the function returns. 
;                   
;                   If the value at the lower memory address is smaller or 
;                   equal to the value at the higher memory address, then the 
;                   function does not modify the array and returns.
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
	NOT R3, R2	;negate R2
	ADD R3, R3, #1	;complete negation
	ADD R3, R3, R1	;Add lower mem address value
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

