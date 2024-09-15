// Initialize R0 with the first element of the array
@1
D=M      // D = RAM[1] (start address of the array)
@INDEX
M=D      // Store start address in INDEX

@2
D=M      // D = RAM[2] (length of the array)
@COUNTER
M=D      // COUNTER = length of the array

// Check if array is empty
@COUNTER
D=M
@END
D;JLE    // If length <= 0, end the loop

// Load first element
@INDEX
A=M      // A = address of first element
D=M      // D = value of first element
@0
M=D      // R0 = first element (initial minimum)

(LOOP)
@COUNTER
D=M
@END
D;JLE    // If COUNTER <= 0, end the loop

@INDEX
A=M      // A = address of current element
D=M      // D = value of current element
@0
D=M-D    // D = current minimum - current element (reversed for overflow handling)

// Handle potential overflow
@SKIP
D;JLE    // If D <= 0, current minimum is still smaller or equal

// Update minimum (avoiding potential overflow)
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