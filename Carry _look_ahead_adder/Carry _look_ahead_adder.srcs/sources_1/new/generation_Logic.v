
module generation_Logic(
input [15:0] A,B,
output  [15:0] p,g
    );
     generate 
       genvar k;
       for(k=0;k<16;k=k+1) begin: stage
         assign p[k]=A[k]^B[k];
         assign g[k]=A[k] & B[k];
       end
       endgenerate
endmodule
