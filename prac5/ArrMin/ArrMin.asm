//R1 contains the RAM address of the first element in the array
// R2 contains the length of the array  
  
// Calculate end address of array
@R1
D=M-1
@R2
M=M+D    // R2 = R1 + R2 - 1 (end address of array)

// Initialize R0 with maximum possible value
@32767
D=A
@R0
M=D     

(LOOP)
(CHECK_TERMINATE)
    @R1
    D=M
    @R2
    D=D-M
    @END
    D;JGT  // If current address > end address, terminate

    @R1
    A=M
    D=M   
    @ELEM_POS
    D;JGE  // If element >= 0, go to ELEM_POS
    @ELEM_NEG
    0;JMP  // Else, go to ELEM_NEG

(UPDATE)
    @R1
    A=M
    D=M
    @R0
    M=D    // Update R0 with new minimum

(SKIP)
    @R1
    M=M+1  // Move to next element
    @LOOP
    0;JMP  // Continue

(END)
    @END
    0;JMP  // end

(R0_NEG)
    @R1
    A=M
    D=M
    @R0
    D=D-M  // D = current element - R0
    @SKIP
    D;JGE  // If D >= 0, skip update
    @UPDATE
    0;JMP  // Else, update R0

(R0_POS)
    @R1
    A=M
    D=M
    @R0
    D=D-M  // D = current element - R0
    @SKIP
    D;JGE  // If D >= 0, skip update
    @UPDATE
    0;JMP  // Else, update R0

(ELEM_NEG)
    @R0
    D=M
    @R0_NEG
    D;JLT  // If R0 < 0, go to R0_NEG
    @UPDATE
    0;JMP  // Else, update R0

(ELEM_POS)
    @R0
    D=M
    @R0_POS
    D;JGE  // If R0 >= 0, go to R0_POS
    @SKIP
    0;JMP  // Else, skip update