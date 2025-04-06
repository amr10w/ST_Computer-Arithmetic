`timescale 1ns / 1ps 
module tb_16Bit;
    // Parameters 
    parameter N = 16; 
    // Inputs 
    reg [N-1:0] a; 
    reg [N-1:0] b; 
    reg cin; 
    // Outputs 
    wire [N-1:0] sum; 
    wire cout; 
    // Instantiate the Unit Under Test (UUT) 
    CLA_16Bit #(N) uut ( 
        .A(a), 
        .B(b), 
        .Cin(cin), 
        .sum(sum), 
        .Cout(cout) 
    ); 
    initial begin 
        a = 0; 
        b = 0; 
        cin = 0; 
        // Apply test vectors
        #10 a = 16'b0000000000000001; b = 16'b0000000000000001; cin = 0; // 1 + 1 = 2 
        #10 a = 16'b0000000000111111; b = 16'b0000000000000001; cin = 0; // 15 + 1 = 16 
        #10 a = 16'b1111111111111111; b = 16'b0000000000000001; cin = 0; // 255 + 1 = 256 
        #10 a = 16'b0101010101010101; b = 16'b1010101010101010; cin = 0; // 170 + 85 = 255 
        #10 a = 16'b1111000000000000; b = 16'b0000111100000000; cin = 1; // 240 + 15 + 1 = 256 
        #10 a = 16'b0000000000000000; b = 16'b0000000000000000; cin = 1; // 0 + 0 + 1 = 1

               // Add more test cases as needed 
               #10 $stop; // Stop the simulation 
           end 
           initial begin 
               $monitor("At time %t, a = %b, b = %b, cin = %b, sum = %b, cout = %b", 
                        $time, a, b, cin, sum, cout); 
           end 
       endmodule 