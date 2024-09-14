// ArrSort.asm

// Input:
// R1: RAM address of the first element in the array
// R2: Length of the array

// Output:
// R0: True (-1) when sorting is complete

// Bubble Sort implementation
@LOOP
D=M              // Load the length of the array
@END_LOOP
D=D-1            // Decrement to account for zero-based indexing
@R2
M=D              // Store the updated length

@R1
D=M              // Load the address of the first element
@R2
D=D-1            // Adjust for zero-based indexing (last element address)
@OUTER_LOOP
D;JLE            // If length <= 1, exit the loop

// Inner loop for comparisons and swaps
@R1
M=D              // Set the current element address
@INNER_LOOP
D=M              // Load the current element value
@R1
A=M+1            // Address of the next element
D=D-M            // Compare current and next elements
@SWAP
D;JGT            // If D > 0, swap needed
@NO_SWAP
0;JMP            // Otherwise, continue without swapping

// Swap elements
(SWAP)
@R1
A=M              // Address of the current element
D=M              // Load the current element value
@R1
A=M+1            // Address of the next element
M=D              // Store the current element value in the next element
@R1
M=M+1            // Move to the next pair of elements
@INNER_LOOP
0;JMP

// No swap needed
(NO_SWAP)
@R1
M=M+1            // Move to the next pair of elements
@INNER_LOOP
0;JMP

// End of outer loop
(END_LOOP)
@LOOP
0;JMP

// Finished sorting
@R0
M=-1             // Set R0 to True
