// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place. Sets R0 to True (-1) when complete.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
@R1
D=M

@R2
D=M
@TRACK
M=D-1

@R2
D=M
@TRACK_LOOP
M=D-1

@R1
D=M
@CURR
M=D

@CURR
A=M
D=M

@IS_POS
D;JGE
@IS_NEG
D;JLT

(IS_POS)
@CURR
A=M+1
D=M

@VAL_SWAP
D;JLT

@LOOP
D;JGE

(IS_NEG)
@CURR
A=M+1
D=M

@NEXT
D;JGE

@LOOP
D;JLT

(LOOP)
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
@CURR
M=M+1
D=M
@TRACK
M=M-1
D=M
@NEXT_LOOP
D;JEQ

(SIGN)
@CURR
A=M
D=M
@IS_POS
D;JGE
@IS_NEG
D;JLT


(NEXT_LOOP)
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
@R0
M=-1
@END
0;JMP