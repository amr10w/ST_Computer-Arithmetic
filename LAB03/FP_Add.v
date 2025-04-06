(* DONT_TOUCH = "TRUE" *)
module FP_Add(
    input clk,
    input rst,
    input [31:0] a ,
    input [31:0] b ,
    output reg done,
    output [31:0] out 
);

wire        a_sign ;
wire [7:0]  a_Exponent;
wire [23:0] a_fraction;
wire        b_sign;
wire [7:0]  b_Exponent;
wire [23:0] b_fraction;

reg        a_sign_reg ;
reg [7:0]  a_Exponent_reg;
reg [23:0] a_fraction_reg;
reg        b_sign_reg;
reg [7:0]  b_Exponent_reg;
reg [23:0] b_fraction_reg;

reg [3:0] state;

wire [7:0]  e_ab ;
reg  [7:0]  Exponent ;
reg         sign_reg;
wire [23:0] addfrac ;
wire        carry;
reg [23:0]  outfrac_reg;
wire        cin;
wire        signlogic;
reg         carry_reg;

initial 
begin
    state = 0 ;
    done =0;
    sign_reg=0;
    Exponent=0;
    outfrac_reg=0;
    carry_reg=0;

end

unpack unpacka (
    .x(a),
    .sign(a_sign),
    .Exponent(a_Exponent),
    .Fraction_withhidden_1(a_fraction)
);
unpack unpackb (
    .x(b),
    .sign(b_sign),
    .Exponent(b_Exponent),
    .Fraction_withhidden_1(b_fraction)
);

assign e_ab = (a_Exponent>b_Exponent) ? a_Exponent - b_Exponent : b_Exponent - a_Exponent ;
assign cin = a_sign ^ b_sign ;
assign signlogic = (a[30:0]>b[30:0]) ? 1:0;

Add add_sub (
    .a(a_fraction_reg),
    .b(b_fraction_reg),
    .cin(cin),
    .s(addfrac),
    .cout(carry)
);

always @(posedge clk or posedge rst)
begin
    if (rst==1)
    begin
        state = 0 ;
        done =0;
        sign_reg=0;
        Exponent=0;
        outfrac_reg=0;
        carry_reg=0;
    end

    else
    begin
        case (state)
        0:
        
        begin
            if (b[30:0]==0 )
            begin
                sign_reg <= a_sign;
                Exponent <= a_Exponent;
                outfrac_reg<=a_fraction;
                state <=7;
            end
            else
                if (a[30:0]==0 )
                begin
                    sign_reg <= b_sign;
                    Exponent <= b_Exponent;
                    outfrac_reg<=b_fraction;
                    state <=7;
                end
            else
                if (b[30:0]==a[30:0] && a_sign != b_sign)
                begin
                    sign_reg <= 0;
                    Exponent <= 0;
                    outfrac_reg<=0;
                    state <=7;
                end
            else
                begin
                    a_sign_reg <= a_sign;
                    a_Exponent_reg<=a_Exponent;
                    a_fraction_reg<=a_fraction;
                    b_sign_reg<=b_sign;
                    b_Exponent_reg<=b_Exponent;
                    b_fraction_reg<=b_fraction;
                    state <=1;
                end
        end
        1:

        begin
            if (a_Exponent>b_Exponent) 
            begin
                b_fraction_reg <= b_fraction_reg >> e_ab;
                Exponent<=a_Exponent;
                state <=2;
            end
            else if (a_Exponent<b_Exponent)
            begin
                a_fraction_reg <= a_fraction_reg >> e_ab;
                Exponent<=b_Exponent;
                state <=2;
            end
            else
            begin
                Exponent<=b_Exponent;
                state <=2;
            end
        end
        2:

        begin
            if (cin)
            begin
                if (a_sign_reg)
                begin
                    sign_reg<= signlogic  ;
                    a_fraction_reg<=~a_fraction_reg;
                    state <= 3;
                end
            else
            begin
                sign_reg<= !signlogic  ;
                b_fraction_reg<=~b_fraction_reg;
                state <=3;
            end
            end 
            else 
            begin
                sign_reg<= a_sign_reg;
                state <=3;
            end
        end
        3: 
        begin
            outfrac_reg<=addfrac;
            carry_reg<=carry;
            state <=4;
        end
        4:
        begin
            if (!cin)
            begin
                if (carry_reg && outfrac_reg[23] != 1 )
                begin
                    Exponent<= Exponent+1;
                    outfrac_reg<=addfrac>>1;
                    state <=6;
                    carry_reg<=0;
                end
            else if(outfrac_reg[23] != 1)
            begin
                state <= 5 ;
            end
            else
            begin
                outfrac_reg<=addfrac;
                state <=6;
            end
            end
            else
            begin
                if (!carry_reg)
                begin
                    outfrac_reg = ~outfrac_reg +1;
                    state <= 4;
                    carry_reg<=1;
                end
                else if (outfrac_reg[23]!=1)
                begin
                    state <= 5;
                end
                else
                begin
                    state <=6;
                end
            end
        end
        5:
        begin
            outfrac_reg<= outfrac_reg<< 1 ;
            Exponent<= Exponent-1;
            state <= 4;
        end
        6:
        begin
            if (Exponent == 255 || Exponent ==0 )
            begin
                state<= 7;
            end
            else 
            begin
                state <=7;
            end
        end
        7:
        begin
            state<= 8  ;
            done <= 1  ;
        end 
        8:
        begin
            state<= 0;
            done<=0;
        end
        endcase 
    end
end
                


pack pack (
.x(out),
.sign(sign_reg),
.Exponent(Exponent),
.Fraction_withhidden_1(outfrac_reg)
);






endmodule