
load AddSub.asm,
output-file AddSub01.out,
compare-to AddSub01.cmp,
output-list RAM[0]%D2.6.2 RAM[1]%D2.6.2 RAM[2]%D2.6.2 RAM[3]%D2.6.2;

set PC 0,
set RAM[0] 0, 
set RAM[1] 5,  
set RAM[2] -3,
set RAM[3] 7;  
repeat 100 {
  ticktock;    // Run for 100 clock cycles
}
set RAM[1] 5,  // Restore arguments in case program used them
set RAM[2] -3,
set RAM[3] 7,
output;        // Output to file

