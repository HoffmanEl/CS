// Bubble Sort Implementation
// R1: Base address of the array
// R2: Length of the array
// R0: Will be set to -1 when sorting is complete

// Initialize outer loop counter
@R2
D=M
@n
M=D      // n = length of array

(OUTER_LOOP)
@n
D=M
@END
D;JLE    // If n <= 1, end sorting (array is sorted)

// Initialize inner loop counter and swap flag
@i
M=0      // i = 0
@swapped
M=0      // swapped = false (0)

(INNER_LOOP)
@n
D=M
@i
D=D-M
D=D-1
@OUTER_LOOP_END
D;JLE    // If i >= n-1, end inner loop

// Compare arr[i] and arr[i+1]
@R1
D=M
@i
A=D+M    // Address of arr[i]
D=M      // D = arr[i]
@temp
M=D      // temp = arr[i]

@R1
D=M
@i
D=D+M
A=D+1    // Address of arr[i+1]
D=M      // D = arr[i+1]

@temp
D=D-M    // D = arr[i+1] - arr[i]

@SKIP_SWAP
D;JGE    // If arr[i+1] >= arr[i], skip swap

// Swap arr[i] and arr[i+1]
@R1
D=M
@i
A=D+M    // Address of arr[i]
D=M      // D = arr[i]
@temp
M=D      // temp = arr[i]

@R1
D=M
@i
D=D+M
A=D+1    // Address of arr[i+1]
D=M      // D = arr[i+1]
@R1
A=M
@i
A=D+M    // Address of arr[i]
M=D      // arr[i] = arr[i+1]

@temp
D=M      // D = temp (original arr[i])
@R1
A=M
@i
D=D+M
A=D+1    // Address of arr[i+1]
M=D      // arr[i+1] = temp

@swapped
M=-1     // Set swapped flag to true (-1)

(SKIP_SWAP)
@i
M=M+1    // i++
@INNER_LOOP
0;JMP

(OUTER_LOOP_END)
@swapped
D=M
@OUTER_LOOP
D;JNE    // If swapped is true (-1), continue outer loop

@n
M=M-1    // n--
@OUTER_LOOP
0;JMP

(END)
@R0
M=-1     // Set R0 to -1 to indicate completion

(INFINITE_LOOP)
@INFINITE_LOOP
0;JMP    // Infinite loop to end the program