module CLA_64_Bit (
    input [63:0] A, B,
    input Cin,
    output [63:0] sum,
    output Cout
);
    wire [63:0] p, g;
    wire [3:0] P_Group, G_Group; 
    wire [63:0] C; 
    wire [2:0] Co; 
    assign C[16]=Co[0];
    assign C[32]=Co[1];
    assign C[48]=Co[2];
    assign C[0] = Cin;
    SUM_64_bit sum_logic (
        .C(C[63:0]),
        .p(p),
        .sum(sum)
    );
    generation_Logic_64Bit generation_logic (
        .A(A),
        .B(B),
        .g(g),
        .p(p)
    );
    Bit16_CLA CLA0 (
        .p(p[15:0]),
        .g(g[15:0]),
        .Cin(Cin),
        .c(C[15:0]),
        .Pg(P_Group[0]),
        .Gg(G_Group[0])    
    );
    Bit16_CLA CLA1 (
        .p(p[31:16]),
        .g(g[31:16]),
        .Cin(Co[0]),
        .c(C[31:17]),
        .Pg(P_Group[1]),
        .Gg(G_Group[1])     
    );
    Bit16_CLA CLA2 (
        .p(p[47:32]),
        .g(g[47:32]),
        .Cin(Co[1]),
        .c(C[47:33]),
        .Pg(P_Group[2]),
        .Gg(G_Group[2])
    );
    Bit16_CLA CLA3 (
        .p(p[63:48]),
        .g(g[63:48]),
        .Cin(Co[2]),
        .c(C[63:49]),
        .Pg(P_Group[3]),
        .Gg(G_Group[3])
    );
       bit_4_Carry_Look_Ahead CLA_level_3(
    .p(P_Group[3:0]),
    .g(G_Group[3:0]),
    .cin(Cin),
    .C({Cout,Co[2:0]})  
    );
endmodule
