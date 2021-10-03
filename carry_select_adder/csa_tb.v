`include "carrySelectAdder.v"
`timescale 10ps / 1ps


module csa_tb;

  reg [15:0] A;
  reg [15:0] B;
  wire [15:0] Y;
  reg mod;
  wire overflow;

  initial begin

    $dumpfile("tb.vcd");
    $dumpvars(0, csa_tb);

    mod <= 0;

    A <= 16'd0;
    B <= 16'd0;


    #5;
    A <= 16'b1000_0000_0111_1000;
    B <= 16'b1000_0000_0111_1000;
    $display("result : %d", Y);

    #5;
    A <= 16'b1111_1111_1111_1111;
    B <= 16'b1111_1111_1111_1111;
    $display("result : %d", Y);

    #5;
    mod <= 1;
    $display("result : %d", Y);

    #10;
    $display("result : %d", Y);

  end

  CSA tb0(A, B, mod, Y, overflow);

endmodule
