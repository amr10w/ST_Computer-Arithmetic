module generation_Logic_64Bit(
input [63:0] A,B,
output  [63:0] p,g
    );
     generate 
       genvar k;
       for(k=0;k<64;k=k+1) begin: stage
         assign p[k]=A[k]^B[k];
         assign g[k]=A[k] & B[k];
       end
       endgenerate
    
endmodule
