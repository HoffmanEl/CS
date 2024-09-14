// Initialize R0 with the first element of the array
@1
D=M      // D = RAM[1] (start address of the array)
A=D      // A = address of the first element
D=M      // D = value of the first element
@0
M=D      // R0 = first element (initial minimum)

// Initialize loop counter
@2
D=M      // D = RAM[2] (length of the array)
@COUNTER
M=D      // COUNTER = length of the array

// Initialize array index
@1
D=M      // D = RAM[1] (start address of the array)
@INDEX
M=D      // INDEX = start address of the array

(LOOP)
@COUNTER
D=M
@END
D;JLE    // If COUNTER <= 0, end the loop

@INDEX
A=M      // A = address of current element
D=M      // D = value of current element
@0
D=D-M    // D = current element - current minimum
@SKIP
D;JGE    // If D >= 0, skip to next element

@INDEX
A=M
D=M
@0
M=D      // Update R0 with new minimum

(SKIP)
@INDEX
M=M+1    // Move to next element
@COUNTER
M=M-1    // Decrement COUNTER
@LOOP
0;JMP

(END)
@END
0;JMP