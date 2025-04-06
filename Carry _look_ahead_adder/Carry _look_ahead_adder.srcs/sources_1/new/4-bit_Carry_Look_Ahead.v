module bit_4_Carry_Look_Ahead(
    input [3:0] p,g,
    input cin,
    output [3:0] C,
    output G,P
    
    );
    CLA_4_Bit ALU(
    
    .p(p),
    .g(g),
    .cin(cin),
    .P(P),
    .G(G),
    .c(C)
    
    );
endmodule
