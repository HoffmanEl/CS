// Improved Bubble Sort Implementation
// R1: Base address of the array
// R2: Length of the array (represented as negative value)
// R0: Will be set to -1 when sorting is complete

// Initialize
@R2
D=M
@length
M=D      // length = R2 (negative value)

// Check if array is empty or has one element
@length
D=M
@END
D;JGE    // If length >= 0, end sorting (array is empty or has one element)

// Initialize outer loop counter
@outerCounter
M=-1     // Start from -1 to handle length stored as negative

(OUTER_LOOP)
@length
D=M
@outerCounter
D=D-M
@END
D;JEQ    // If outerCounter == |length|, end sorting

// Initialize inner loop counter and swap flag
@innerCounter
M=0      // innerCounter = 0
@swapped
M=0      // swapped = false (0)

(INNER_LOOP)
@length
D=M
@innerCounter
D=D+M    // D = length + innerCounter
@outerCounter
D=D-M
D=D+1
@OUTER_LOOP_END
D;JGE    // If innerCounter >= |length| + outerCounter + 1, end inner loop

// Compare arr[i] and arr[i+1]
@R1
D=M
@innerCounter
A=D+M    // Address of arr[i]
D=M      // D = arr[i]
@temp1
M=D      // temp1 = arr[i]

@R1
D=M
@innerCounter
D=D+M
A=D+1    // Address of arr[i+1]
D=M      // D = arr[i+1]
@temp2
M=D      // temp2 = arr[i+1]

// Compare using subtraction (works for both positive and negative numbers)
@temp2
D=M
@temp1
D=D-M    // D = arr[i+1] - arr[i]

@SKIP_SWAP
D;JGE    // If arr[i+1] >= arr[i], skip swap

// Swap arr[i] and arr[i+1]
@R1
D=M
@innerCounter
A=D+M    // Address of arr[i]
D=A
@addr1
M=D      // Store address of arr[i]

@R1
D=M
@innerCounter
D=D+M
A=D+1    // Address of arr[i+1]
D=A
@addr2
M=D      // Store address of arr[i+1]

@temp1
D=M
@addr2
A=M
M=D      // arr[i+1] = temp1 (original arr[i])

@temp2
D=M
@addr1
A=M
M=D      // arr[i] = temp2 (original arr[i+1])

@swapped
M=-1     // Set swapped flag to true (-1)

(SKIP_SWAP)
@innerCounter
M=M+1    // innerCounter++
@INNER_LOOP
0;JMP

(OUTER_LOOP_END)
@swapped
D=M
@OUTER_LOOP_CONTINUE
D;JNE    // If swapped is true (-1), continue outer loop

@END
0;JMP    // If no swaps were made, the array is sorted

(OUTER_LOOP_CONTINUE)
@outerCounter
M=M+1    // outerCounter++
@OUTER_LOOP
0;JMP

(END)
@R0
M=-1     // Set R0 to -1 to indicate completion

(INFINITE_LOOP)
@INFINITE_LOOP
0;JMP    // Infinite loop to end the program