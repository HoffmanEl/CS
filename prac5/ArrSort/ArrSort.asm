// Bubble Sort Implementation
// R1: Base address of the array
// R2: Length of the array
// R0: Will be set to -1 when sorting is complete

// Initialize
@R2
D=M
@n
M=D      // n = length of array

// Outer loop (i)
(OUTER_LOOP)
@n
D=M
@END
D;JLE    // If n <= 0, end sorting

@i
M=0      // i = 0

// Inner loop (j)
(INNER_LOOP)
@n
D=M
@i
D=D-M
D=D-1
@OUTER_LOOP_END
D;JLE    // If i >= n-1, end inner loop

// Compare arr[j] and arr[j+1]
@R1
D=M
@i
A=D+M    // Address of arr[j]
D=M      // D = arr[j]
@temp
M=D      // temp = arr[j]

@R1
D=M
@i
D=D+M
A=D+1    // Address of arr[j+1]
D=M      // D = arr[j+1]
@temp
D=D-M    // D = arr[j+1] - arr[j]

@SKIP_SWAP
D;JGE    // If arr[j+1] >= arr[j], skip swap

// Swap arr[j] and arr[j+1]
@R1
D=M
@i
A=D+M    // Address of arr[j]
D=M      // D = arr[j]
@temp
M=D      // temp = arr[j]

@R1
D=M
@i
D=D+M
A=D+1    // Address of arr[j+1]
D=M      // D = arr[j+1]
@R1
A=M
@i
A=D+M    // Address of arr[j]
M=D      // arr[j] = arr[j+1]

@temp
D=M      // D = temp (original arr[j])
@R1
A=M
@i
D=D+M
A=D+1    // Address of arr[j+1]
M=D      // arr[j+1] = temp

(SKIP_SWAP)
@i
M=M+1    // i++
@INNER_LOOP
0;JMP

(OUTER_LOOP_END)
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