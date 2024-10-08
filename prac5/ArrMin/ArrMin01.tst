
load ArrMin.asm,
output-file ArrMin01.out,
compare-to ArrMin01.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[20]%D2.6.2 RAM[21]%D2.6.2 RAM[22]%D2.6.2 RAM[23]%D2.6.2;

set PC 0,
set RAM[0]  0,  // Set R0
set RAM[1]  20, // Set adress
set RAM[2]  4,  // Set length 
set RAM[20] 3,  // Set Arr[0]
set RAM[21] 4,  // Set Arr[1]
set RAM[22] 5,  // Set Arr[2]
set RAM[23] 6;  // Set Arr[3]

repeat 300 {
  ticktock;    // Run for 300 clock cycles
}
set RAM[1] 2,  // Restore arguments in case program used them
set RAM[2] 3,
output;        // Output to file

