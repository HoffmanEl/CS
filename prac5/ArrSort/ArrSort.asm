
@SP
M=256 // Set stack pointer to the top of the stack

// Variables
@arr
M=0 // Initialize the array pointer
@i
M=0 // Initialize the outer loop counter
@j
M=0 // Initialize the inner loop counter
@temp
M=0 // Initialize the temporary variable

// Main program
(LOOP)
    // Load the array element at index i into D
    @arr
    A=M
    D=M

    // Load the array element at index i+1 into A
    @arr
    A=M+1

    // Compare D and A
    D=D-A

    // If D > 0, swap the elements
    D;JGT
    @arr
    A=M
    M=D
    @arr
    A=M+1
    M=D+1

    // Increment the inner loop counter
    @j
    M=M+1

    // Check if the inner loop counter reached n-i-1
    @n
    D=M
    @i
    D=D-A-1
    @j
    D=D+M
    @LOOP
    D;JLT

    // Increment the outer loop counter
    @i
    M=M+1

    // Check if the outer loop counter reached n-1
    @n
    D=M
    @i
    D=D-A-1
    @LOOP
    D;JLT

// End of program
(END)
    @END
    0;JMP