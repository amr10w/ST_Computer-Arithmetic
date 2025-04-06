`timescale 1ns / 1ps


module generate_propagate_signals(
input A,B,
output g,p
    );
    
    assign p=A^B;
    assign g=A & B;
endmodule
