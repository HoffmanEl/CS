@0
M=0      // Initialize R0 to 0 (False)

@2
D=M      // D = R2 (length of the array)
@n
M=D      // Store length of array in n

@1
D=M      // D = R1 (start address of the array)
@arr
M=D      // Store start address of the array in arr

// Outer loop
(OUTER_LOOP)
@n
D=M
@END
D;JLE    // If n <= 0, end sorting

@i
M=0      // i = 0

// Inner loop
(INNER_LOOP)
@i
D=M
@n
D=M-D
D=D-1
@OUTER_LOOP_END
D;JLE    // If i >= n-1, end inner loop

// Compare arr[i] and arr[i+1]
@arr
D=M
@i
A=D+M    // Address of arr[i]
D=M      // D = arr[i]
@temp
M=D      // temp = arr[i]

@arr
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
@arr
D=M
@i
A=D+M    // Address of arr[i]
D=M      // D = arr[i]
@temp
M=D      // temp = arr[i]

@arr
D=M
@i
D=D+M
A=D+1    // Address of arr[i+1]
D=M      // D = arr[i+1]
@arr
A=M
@i
A=D+M    // Address of arr[i]
M=D      // arr[i] = arr[i+1]

@temp
D=M      // D = temp (original arr[i])
@arr
A=M
@i
D=D+M
A=D+1    // Address of arr[i+1]
M=D      // arr[i+1] = temp

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
@0
M=-1     // Set R0 to True (-1) to indicate completion
(INFINITE_LOOP)
@INFINITE_LOOP
0;JMP    // Infinite loop to end the program