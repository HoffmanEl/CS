// Sorts stuff in RAM[R1] with length R2. Makes it go up order. R0 = True (-1) when done.
// (R0, R1, R2 are like RAM[0], RAM[1], RAM[2], you know?)

// Set up variables
@R1
D=M
@R2
D=M
@TRACK      // TRACK is for counting to compare each time
M=D-1
@R2
D=M
@TRACK_LOOP // TRACK_LOOP counts how many times we go through everything
M=D-1
@R1
D=M
@CURR       // CURR is current iteration
M=D

// Check if first number is positive or negative
@CURR
A=M
D=M
@IS_POS
D;JGE
@IS_NEG
D;JLT

(IS_POS)
// If it's +'ve, see if next one's -'ve and swap if true
@CURR
A=M+1
D=M
@VAL_SWAP
D;JLT
@LOOP
D;JGE

(IS_NEG)
// If it's -'ve, check if next one's +'ve (swap needed)
@CURR
A=M+1
D=M
@NEXT
D;JGE
@LOOP
D;JLT

(LOOP)
// Compare current number with next one
@CURR
A=M
D=M
A=A+1
D=D-M
@VAL_SWAP
D;JGT

@NEXT
0;JMP

(VAL_SWAP)
// Swap if they're in the wrong order
@CURR
A=M+1
D=M

@TEMP
M=D

@CURR
A=M
D=M
A=A+1
M=D

@TEMP
D=M

@CURR
A=M
M=D

(NEXT)
// Move to next number and count down
@CURR
M=M+1
D=M
@TRACK
M=M-1
D=M
@NEXT_LOOP
D;JEQ

(SIGN)
// Check if current number is +'ve or -'ve
@CURR
A=M
D=M
@IS_POS
D;JGE
@IS_NEG
D;JLT

(NEXT_LOOP)
// Start over from the beginning and count down how many times gone through
@R1
D=M
@CURR
M=D

@TRACK_LOOP
M=M-1
D=M
@TRACK
M=D
@END
D;JEQ
@LOOP
D;JGT

(END)
// Set R0 to -1 cuz that means True for some reason
@R0
M=-1
@END
0;JMP