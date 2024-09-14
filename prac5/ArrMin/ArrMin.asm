// Finds the smallest element in the array of length R2 whose first element is at RAM[R1] and stores the result in R0.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// Put your code here.
// Find the smallest element in the array and store it in R0

// Initialize R0 to the first element of the array
@1       // Address of RAM[1] (R1)
D=M      // D = RAM[1] (first element of the array)
@0       // Address of RAM[0] (R0)
M=D      // Store the first element in R0 as the initial minimum

// Set up loop counter
@2       // Address of RAM[2] (R2)
D=M      // D = RAM[2] (length of the array)
@COUNTER
M=D      // Store length in COUNTER

// Set up array index
@1       // Address of RAM[1] (R1)
D=M      // D = RAM[1] (start address of the array)
@INDEX
M=D      // Store the start address in INDEX

// Start loop
(LOOP)
@COUNTER
D=M      // D = COUNTER (remaining elements to check)
@END
D;JEQ    // If COUNTER == 0, jump to END

@INDEX
D=M      // D = INDEX (current element address)
A=D      // A = address of the current element
D=M      // D = value of the current element

@0       // Address of RAM[0] (R0)
D=D-M    // D = value of the current element - current min
@SMALLER
D;JLT    // If value of the current element < current min, jump to SMALLER

@INDEX
D=M      // D = INDEX (current element address)
@1       // Address of RAM[1] (R1)
D=D+1    // Increment INDEX to the next element
@INDEX
M=D      // Store the new INDEX value

@COUNTER
D=M      // D = COUNTER
@1
D=D-1    // Decrement COUNTER
@COUNTER
M=D      // Store the new COUNTER value

@LOOP
0;JMP    // Jump to start of the loop

// Update minimum
(SMALLER)
@0       // Address of RAM[0] (R0)
M=D      // Store the new minimum in R0

@INDEX
D=M      // D = INDEX (current element address)
@1       // Address of RAM[1] (R1)
D=D+1    // Increment INDEX to the next element
@INDEX
M=D      // Store the new INDEX value

@COUNTER
D=M      // D = COUNTER
@1
D=D-1    // Decrement COUNTER
@COUNTER
M=D      // Store the new COUNTER value

@LOOP
0;JMP    // Jump to start of the loop

// End of the program
(END)
@END
0;JMP    // Infinite loop to end the program
