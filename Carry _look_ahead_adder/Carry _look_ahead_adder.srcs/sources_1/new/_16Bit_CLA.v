module Bit16_CLA(
    input [15:0] g,p,
    input Cin,
    output [15:0] c,
     output Pg,Gg,
    output C_16
    );
     wire [3:0] P1,G1;
     wire [2:0] C_i;
     assign c[0]=Cin;
     assign c[4] =C_i[0];
     assign c[8] =C_i[1];
     assign c[12] =C_i[2];    
    bit_4_Carry_Look_Ahead CLA0(
    .p(p[3:0]),
    .g(g[3:0]),
    .cin(Cin),
    .C(c[3:1]),
    .P(P1[0]),
    .G(G1[0])    
    );
     bit_4_Carry_Look_Ahead CLA1(
       .p(p[7:4]),
       .g(g[7:4]),
       .cin(c[4]),
       .C(c[7:5]),
       .P(P1[1]),
       .G(G1[1])    
       );
        bit_4_Carry_Look_Ahead F_CLA2(
          .p(p[11:8]),
          .g(g[11:8]),
          .cin(c[8]),
          .C(c[11:9]),
          .P(P1[2]),
          .G(G1[2])      
          );
           bit_4_Carry_Look_Ahead F_CLA3(
             .p(p[15:12]),
             .g(g[15:12]),
             .cin(c[12]),
             .C(c[15:13]),
             .P(P1[3]),
             .G(G1[3])         
             );
              bit_4_Carry_Look_Ahead S_CLA(
                .p(P1[3:0]),
                .g(G1[3:0]),
                .cin(Cin),
                .C(C_i),
                .P(Pg),
                .G(Gg)
                );   
endmodule
