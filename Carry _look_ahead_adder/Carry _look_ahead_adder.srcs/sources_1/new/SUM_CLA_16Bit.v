`timescale 1ns / 1ps


module SUM_CLA_16Bit(
input [15:0] C,p,
output [15:0] sum
    );
    generate 
           genvar k;
           for(k=0;k<16;k=k+1) begin: stage
             assign sum[k]=C[k]^p[k];
            
           end
           endgenerate
endmodule
