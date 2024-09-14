// Initialize R0 to 0 (the result)
@0
M=0

// Load R2 (the multiplier) into D register
@2
D=M

// Check if R2 is 0
@END
D;JEQ

// Check if R2 is negative
@POSITIVE
D;JGE

// If R2 is negative, make it positive and set a flag
@NEG_FLAG
M=-1
@2
M=-M
@POSITIVE
0;JMP

(POSITIVE)
// Initialize loop counter
@2
D=M
@COUNTER
M=D

(LOOP)
@COUNTER
D=M
@SIGN_CHECK
D;JLE    // If COUNTER <= 0, check the sign

@1       // Address of RAM[1] (R1)
D=M      // D = RAM[1]
@0       // Address of RAM[0] (R0)
M=M+D    // R0 = R0 + R1

@COUNTER
M=M-1    // Decrement COUNTER

@LOOP
0;JMP

(SIGN_CHECK)
@NEG_FLAG
D=M
@END
D;JEQ    // If NEG_FLAG is 0, end the program

// If NEG_FLAG is -1, negate the result
@0
M=-M

(END)
@END
0;JMP