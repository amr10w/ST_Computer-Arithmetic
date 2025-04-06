

module CLA_16Bit(
    input [15:0] A,B,
    input Cin ,
    output [15:0] sum,
    output Cout
    );
    wire [15:0] p;
    wire [15:0] g;
    wire  P_Group;
    wire  G_Group;
 
    wire [15:0] C;
     
    generation_Logic ALU1(
            .A(A),
            .B(B),
            .g(g),
            .p(p)
            
            );
            
                Bit16_CLA ALU2(
                .p(p),
                .g(g),
                .Cin(Cin),
                .c(C),
                .Pg(P_Group),
                .Gg(G_Group),
                .C_16(Cout)
                );
                
                
       
        SUM_CLA_16Bit ALU3(
            .C({C[15:0]}),
            .p(p),
            .sum(sum)
            );
            
        
   
endmodule
