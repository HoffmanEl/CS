// Sorts the array of length R2 whose first element is at RAM[R1] in ascending order in place.
// Sets R0 to True (-1) when complete.

@0       // Address of RAM[0] (R0)
M=0      // Initialize R0 to 0 (False)

@2       // Address of RAM[2] (R2)
D=M      // D = RAM[2] (length of the array)
@COUNTER
M=D      // Store length of array in COUNTER

@1       // Address of RAM[1] (R1)
D=M      // D = RAM[1] (start address of the array)
@START
M=D      // Store start address of the array in START

// Bubble sort algorithm
(SORT_LOOP)
@COUNTER
D=M      // D = COUNTER
@END
D;JEQ    // If COUNTER == 0, jump to END

@START
D=M      // D = START (current element address)
A=D      // A = address of the current element
D=M      // D = value of the current element
@TMP
M=D      // Store current element value in TMP

// Compare and swap adjacent elements
@START
D=M      // D = START (current element address)
A=D      // A = address of the current element
D=M      // D = value of the current element
@NEXT
D=D+1    // Address of next element
A=D
D=M      // D = value of the next element

@TMP
D=D-M    // D = value of next element - current element
@SWAP
D;JLT    // If next element < current element, jump to SWAP

// Move to the next pair of elements
@START
D=M      // D = START (current element address)
D=D+1    // Address of the next element
@START
M=D      // Store the new START address
@COUNTER
D=M      // D = COUNTER
D=D-1    // Decrement COUNTER
@COUNTER
M=D      // Store new COUNTER value

@SORT_LOOP
0;JMP    // Repeat the loop

// Swap elements
(SWAP)
@START
D=M      // D = START (current element address)
A=D      // A = address of the current element
D=M      // D = value of the current element
@TMP
M=D      // Store the current element value in TMP

// Swap with the next element
@START
D=M      // D = START (current element address)
D=D+1    // Address of the next element
A=D
D=M      // D = value of the next element
@START
D=M      // D = START (current element address)
A=D      // A = address of the current element
M=D      // Set the current element to the next element's value

@TMP
D=M      // D = value stored in TMP
@START
D=M      // D = START (current element address)
D=D+1    // Address of the next element
A=D
M=D      // Set the next element to the value stored in TMP

// Move to the next pair of elements
@START
D=M      // D = START (current element address)
D=D+1    // Address of the next element
@START
M=D      // Store the new START address
@COUNTER
D=M      // D = COUNTER
D=D-1    // Decrement COUNTER
@COUNTER
M=D      // Store new COUNTER value

@SORT_LOOP
0;JMP    // Repeat the loop

// End of the program
(END)
@0
M=-1     // Set R0 to True (-1) to indicate completion
@END
0;JMP    // Infinite loop to end the program

(NEXT)
@START
D=M      // D = START (current element address)
D=D+1    // Address of the next element
@NEXT
M=D      // Store the address of the next element
