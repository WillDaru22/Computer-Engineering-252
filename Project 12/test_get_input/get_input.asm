;******************************************************************************
; Filename:    hw12.asm
; Author:      
; Description: main application for Project 12
;******************************************************************************
	.ORIG x3000

    LEA R0, NUM_ARRAY_1
    JSR GET_INPUT
	
	; ***********
	; Set a break point at the DONE label.  When you tell PennSim to continute,
	; you will need to enter a 3 digit number from the PennSim console.  
	; 
	; Verify that the result returned in R0 is the correct based on the value
	; you entered on the keyboard.
	; ***********
	
 
DONE  BR DONE

NUM_ARRAY_1   .BLKW   10



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
GET_INPUT
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

