; Author(s):   WillDaru22
;              
;
; Description: Performs various operations on values in
;              various memory locations


        .ORIG x0200
START
        LEA R6, data		; get pointer to data array

        ; YOUR CODE GOES BELOW HERE
	LDR R3, R6, #2  ;Loads the value from data[2] and stores it in register 3
	ST R3, A	;Stores the value in register 3 into the memory labelled A
	LDR R4, R6, #1	;Loads the value from data[1] and stores it in register 4
	ST R4, B	;Stores the value in register 4 into the memory labelled B
	NOT R4, R4	;We want to execute the equation C=A-B+20 so we have to do a few different steps.
			;We have to subtract B from A so we negate R4 (which is the same value as B) and add 1 (which we will do later)
	ADD R1, R3, R4	;We then add the negated R4(B) (minus the 1 we need to add later) to R3(same value as A) and store it in R1
	ADD R1, R1, 15	;We then need to add 20 (and 1 to complete the negation we did earlier) 
			;but we cannot add higher than 15 at a time without going out of bounds.  
			;What we do is divide that into 2 parts, 15 and 6 
			;(any two positive whole numbers less than or equal to 15 that add up to 21 work as well).  Add 15 to R1.
	ADD R1, R1, 6	;We add the remaining 6 of 21 to R1 (or whatever sum you have leftover in order to get to 21)
	ST R1, C	;Stores the value in R1 (which is our completed A-B+20) into the memory labelled C
	STR R1, R6, #3	;Stores the value in R1(same value as in C)into memory in the data array at data[3].  
			;We use STR along with R6 and an offset of 3 to access data[3].
		
        ; YOUR CODE GOES ABOVE HERE

        BR START

        ; program data

A       .FILL xABCD
B       .FILL xEF01
C       .FILL x2345

      ; Note: normally we would not comment an array like this,
      ; but we wanted to make it easy to see which element is which
data    .FILL #15	    ; data[0]
        .FILL #10	    ; data[1]
        .FILL #-9	    ; data[2]
        .FILL #17	    ; data[3]
		.FILL #83       ; data[4]
		.FILL #49       ; data[5]
		.FILL #57       ; data[6]
	.END
