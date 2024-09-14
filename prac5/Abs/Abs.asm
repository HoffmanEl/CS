// Calculates the absolute value of R1 and stores the result in R0.
// (R0, R1 refer to RAM[0], and RAM[1], respectively.)

// Put your code here.

// Calculate the absolute value of R1 and store the result in R0.

// Load the value of RAM[1] (R1) into D register
@1        // Address of RAM[1]
D=M       // D = RAM[1]

// Check if the number in D (R1) is negative
@NEGATIVE // If D < 0, jump to NEGATIVE
D;JLT

// If the number is positive or zero, store it in R0
@0        // Address of RAM[0]
M=D       // R0 = R1
@END      // Jump to END
0;JMP

// If the number is negative, negate it
(NEGATIVE)
D=-D      // D = -D (negate the value)

// Store the absolute value in R0
@0        // Address of RAM[0]
M=D       // R0 = |R1|

// End of the program
(END)
@END
0;JMP
