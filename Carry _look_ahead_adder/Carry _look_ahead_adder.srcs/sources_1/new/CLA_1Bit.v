`timescale 1ns / 1ps

module CLA_1Bit(
input A,B,Cin,
output g,p
    );
    
    assign p=A^B;
    assign g=A & B;
endmodule
