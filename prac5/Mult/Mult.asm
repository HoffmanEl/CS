// Improved Mult.asm
// Multiplies R1 and R2 and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Initialize R0 to 0 (the result)
@R0
M=0

// Check if R1 or R2 is 0
@R1
D=M
@END
D;JEQ    // If R1 is 0, jump to END

@R2
D=M
@END
D;JEQ    // If R2 is 0, jump to END

// Initialize sign flag
@sign
M=1

// Check if R1 is negative
@R1
D=M
@R1_POS
D;JGE
@sign
M=-M    // Flip sign
@R1
M=-M    // Make R1 positive

(R1_POS)
// Check if R2 is negative
@R2
D=M
@R2_POS
D;JGE
@sign
M=-M    // Flip sign
@R2
M=-M    // Make R2 positive

(R2_POS)
// Choose smaller number for loop counter
@R1
D=M
@R2
D=D-M
@USE_R2
D;JGT

// Use R1 as counter
@R1
D=M
@counter
M=D
@R2
D=M
@adder
M=D
@LOOP
0;JMP

(USE_R2)
// Use R2 as counter
@R2
D=M
@counter
M=D
@R1
D=M
@adder
M=D

(LOOP)
@counter
D=M
@APPLY_SIGN
D;JLE    // If counter <= 0, apply sign

@adder
D=M
@R0
M=M+D    // R0 += adder

@counter
M=M-1    // Decrement counter

@LOOP
0;JMP

(APPLY_SIGN)
@sign
D=M
@END
D;JGT    // If sign is positive, end the program

// If sign is negative, negate the result
@R0
M=-M

(END)
@END
0;JMP