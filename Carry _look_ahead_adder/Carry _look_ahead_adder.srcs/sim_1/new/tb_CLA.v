// Code your testbench here 
// or browse Examples 
`timescale 1ns / 1ps 
 
module tb_CLA; 
 
    // Parameters 
    parameter N = 64; 
 
    // Inputs 
    reg [N-1:0] a; 
    reg [N-1:0] b; 
    reg cin; 
 
    // Outputs 
    wire [N-1:0] sum; 
    wire cout; 
 
    // Instantiate the Unit Under Test (UUT) 
    CLA_64_Bit #(N) uut ( 
        .A(a), 
        .B(b), 
        .Cin(cin), 
        .sum(sum), 
        .Cout(cout) 
    ); 
 
    initial begin 
        // Initialize Inputs 
        a = 0; 
        b = 0; 
        cin = 0; 
        // Apply test vectors
         #10 a = 64'h0000000000000001;  b = 64'h0000000000000001; cin = 0; // 1 + 1 = 2, no carry-out (Cout = 0)
        #10 a = 64'hFFFFFFFFFFFFFFFF;  b = 64'h0000000000000001;  cin = 0; // Overflow: FFFFFFFFFFFFFFFF + 1 = 0x0000000000000000 (Cout = 1)   
        #10 a = 64'hFFFFFFFF00000000;  b = 64'h00000000FFFFFFFF; cin = 1; // Overflow: FFFFFFFF00000000 + 00000000FFFFFFFF + 1 = 0x0000000000000000 (Cout = 1)
        #10 a = 64'h8000000000000000; b = 64'h8000000000000000; cin = 0; // Overflow: 8000000000000000 + 8000000000000000 = 0x0000000000000000 (Cout = 1)
        #10 a = 64'h7FFFFFFFFFFFFFFF;  b = 64'h0000000000000001; cin = 1; // Overflow: 7FFFFFFFFFFFFFFF + 1 + 1 = 0x8000000000000001 (Cout = 0)
        #10 a = 64'h00000000000FFFF0; b = 64'h00000000FFF03300; cin = 1; // 0 + 0 + 1 = 0x1, no carry-out (Cout = 0)
        #10 a = 64'h0000000000000000; b = 64'h0000000000000000; cin = 1; // 0 + 0 + 1 = 0x1, no carry-out (Cout = 0)
#10 a = 64'h0000000000000000; b = 64'h0000000000000001; cin = 0; // 0 + 1 = 1, no carry-out (Cout = 0)
                #10 a = 64'h0000000000000000; b = 64'h0000000000000001; cin = 1; // 0 + 1 + 1 = 2, no carry-out (Cout = 0)
                #10 a = 64'h0000000000000000; b = 64'hFFFFFFFFFFFFFFFF; cin = 0; // 0 + FFFFFFFFFFFFFFFF = FFFFFFFFFFFFFFFF, no carry-out (Cout = 0)
                #10 a = 64'h7FFFFFFFFFFFFFFF; b = 64'h7FFFFFFFFFFFFFFF; cin = 0; // 7FFFFFFFFFFFFFFF + 7FFFFFFFFFFFFFFF = FFFFFFFFFFFFFFFE, no carry-out (Cout = 0)
                #10 a = 64'h0000000000000001; b = 64'h0000000000000001; cin = 1; // 1 + 1 + 1 = 3, no carry-out (Cout = 0)
                #10 a = 64'h0000000000000001; b = 64'h0000000000000001; cin = 1; // 1 + 1 + 1 = 3, no carry-out (Cout = 0)
                
                // Large input cases
                #10 a = 64'hFFFFFFFFFFFFFFFF; b = 64'hFFFFFFFFFFFFFFFF; cin = 1; // Max value + Max value + 1 = 0x1, carry-out (Cout = 1)
                #10 a = 64'hFFFFFFFFFFFFFFF0; b = 64'h000000000000000F; cin = 0; // FFFFFFFF0 + F = 0xFFFFFFFFF, no carry-out (Cout = 0)
                #10 a = 64'h8000000000000000; b = 64'h8000000000000000; cin = 1; // 0x8000000000000000 + 0x8000000000000000 + 1 = 0x0000000000000001, carry-out (Cout = 1)
// Add more test cases as needed 
          #10 $stop; // Stop the simulation 
      end 
   
      initial begin 
          $monitor("At time %t, a = %h, b = %h, cin = %h, sum = %h, cout = %b", 
                   $time, a, b, cin, sum, cout); 
      end 
   
  endmodule 