// Calculates R1 + R2 - R3 and stores the result in R0.
// (R0, R1, R2, R3 refer to RAM[0], RAM[1], RAM[2], and RAM[3], respectively.)

// Put your code here.
// Load the value of RAM[1] (R1) into D register
@1      // Address of RAM[1]
D=M     // D = RAM[1]

// Add the value of RAM[2] (R2) to D
@2      // Address of RAM[2]
D=D+M   // D = D + RAM[2] (D = R1 + R2)

// Subtract the value of RAM[3] (R3) from D
@3      // Address of RAM[3]
D=D-M   // D = D - RAM[3] (D = R1 + R2 - R3)

// Store the result in RAM[0] (R0)
@0      // Address of RAM[0]
M=D     // RAM[0] = D (R0 = R1 + R2 - R3)
