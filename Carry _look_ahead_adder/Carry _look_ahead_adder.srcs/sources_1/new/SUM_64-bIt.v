module SUM_64_bit(
input [63:0] C,p,
output [63:0] sum
    );
    generate 
           genvar k;
           for(k=0;k<64;k=k+1) begin: stage
             assign sum[k]=C[k]^p[k];
            
           end
           endgenerate
endmodule

