`timescale 1ns / 1ps

module tb_CLA_64_Bit;

    // Inputs
    reg [63:0] a;
    reg [63:0] b;
    reg cin;

    // Outputs
    wire [63:0] sum;
    wire cout;

    // Instantiate the Unit Under Test (UUT)
    CLA_64_Bit uut (
        .A(a),
        .B(b),
        .Cin(cin),
        .sum(sum),
        .Cout(cout)
    );

    initial begin
        // Initialize Inputs
        a = 64'b0;
        b = 64'b0;
        cin = 0;

        // Apply test vectors
       
        #10 a = 64'hFFFF_FFFF_FFFF_FFFF; b = 64'b1; cin = 0;       // Overflow case
      
        // Stop simulation
        #10 $stop;
    end

    initial begin
        $monitor("At time %t, a = %h, b = %h, cin = %b, sum = %h, cout = %b",
                 $time, a, b, cin, sum, cout);
    end

endmodule
