`timescale 10ps / 1ps

/*
 Testbench for 16-bit carry select adder
*/

module csa_tb;

  reg [15:0] A;
  reg [15:0] B;
  reg mod;

  wire [15:0] Y;  
  wire overflow;

  initial begin

    $dumpfile("tb.vcd");
    $dumpvars(0, csa_tb);

    mod <= 0;

    A <= 16'd0;
    B <= 16'd0;


    // For detail, see 'display' lines.
    #5;
    A <= 16'b0000_0000_0000_1100;
    B <= 16'b0000_0000_0000_1010;
    #5;
    $display("\n>> Case 1: Check the carryout propagation of [3:0]");
    $display("A: %b_%b_%b_%b  %d", A[15:12], A[11:8], A[7:4], A[3:0], A);
    $display("B: %b_%b_%b_%b  %d", B[15:12], B[11:8], B[7:4], B[3:0], B);
    $display("Y: %b_%b_%b_%b  %d", Y[15:12], Y[11:8], Y[7:4], Y[3:0], Y);

    #5;
    A <= 16'b0000_0000_1100_0100;
    B <= 16'b0000_0000_1110_0010;
    #5;
    $display("\n>> Case 2: Check the carryout propagation of [7:4]");
    $display("Propagated carryout Y[8]: %b", Y[8]);
    $display("A: %b_%b_%b_%b  %d", A[15:12], A[11:8], A[7:4], A[3:0], A);
    $display("B: %b_%b_%b_%b  %d", B[15:12], B[11:8], B[7:4], B[3:0], B);
    $display("Y: %b_%b_%b_%b  %d", Y[15:12], Y[11:8], Y[7:4], Y[3:0], Y);

    #5;
    A <= 16'b0000_1100_0100_0100;
    B <= 16'b0000_1100_0101_0010;
    #5;
    $display("\n>> Case 3: Check the carryout propagation of [11:8]");
    $display("A: %b_%b_%b_%b  %d", A[15:12], A[11:8], A[7:4], A[3:0], A);
    $display("B: %b_%b_%b_%b  %d", B[15:12], B[11:8], B[7:4], B[3:0], B);
    $display("Y: %b_%b_%b_%b  %d", Y[15:12], Y[11:8], Y[7:4], Y[3:0], Y);

    #5;
    A <= 16'b1100_0100_0100_0100;
    B <= 16'b1100_1011_0101_0010;

    #5;
    $display("\n>> Case 4: Check the overflow bit by checking the carryout propagation of [15:12]");
    $display("A:   %b_%b_%b_%b  %d", A[15:12], A[11:8], A[7:4], A[3:0], A);
    $display("B:   %b_%b_%b_%b  %d", B[15:12], B[11:8], B[7:4], B[3:0], B);
    $display("Y: %b_%b_%b_%b_%b  %d", overflow, Y[15:12], Y[11:8], Y[7:4], Y[3:0], Y);

    #5;    
    mod <= 0;
    A <= 16'b0100_1100_0100_0100;
    B <= 16'b1000_1011_0101_0110;

    #5;
    $display("\n>> Case 5: Check A + B when A > 0, B < 0");
    $display("mod: %b", mod);
    $display("A:   %b_%b_%b_%b  signed: %d", A[15:12], A[11:8], A[7:4], A[3:0], $signed(A));
    $display("B:   %b_%b_%b_%b  signed: %d", B[15:12], B[11:8], B[7:4], B[3:0], $signed(B));
    $display("Y: %b_%b_%b_%b_%b  signed: %d", overflow, Y[15:12], Y[11:8], Y[7:4], Y[3:0], $signed(Y));

    #5;    
    mod <= 0;
    A <= 16'b1000_1100_0100_0100;
    B <= 16'b0000_1011_0101_0110;

    #5;
    $display("\n>> Case 6: Check A + B when A < 0, B > 0");
    $display("mod: %b", mod);
    $display("A:   %b_%b_%b_%b  signed: %d", A[15:12], A[11:8], A[7:4], A[3:0], $signed(A));
    $display("B:   %b_%b_%b_%b  signed: %d", B[15:12], B[11:8], B[7:4], B[3:0], $signed(B));
    $display("Y: %b_%b_%b_%b_%b  signed: %d", overflow, Y[15:12], Y[11:8], Y[7:4], Y[3:0], $signed(Y));

    #5;    
    mod <= 1;
    A <= 16'b1100_1100_0100_0100;
    B <= 16'b1100_1011_0101_0110;

    #5;
    $display("\n>> Case 7: Check A - B = Y with mod = 1 when A > B");
    $display("mod: %b", mod);
    $display("A:   %b_%b_%b_%b  signed: %d", A[15:12], A[11:8], A[7:4], A[3:0], $signed(A));
    $display("B:   %b_%b_%b_%b  signed: %d", B[15:12], B[11:8], B[7:4], B[3:0], $signed(B));
    $display("Y: %b_%b_%b_%b_%b  signed: %d", overflow, Y[15:12], Y[11:8], Y[7:4], Y[3:0], $signed(Y));

    #5;    
    mod <= 1;
    A <= 16'b1111_1111_1111_1110;
    B <= 16'b1111_1111_1111_1111;

    #5;
    $display("\n>> Case 8: Check A - B= Y with mod = 1 when A < B");
    $display("mod: %b", mod);
    $display("A:   %b_%b_%b_%b  signed: %d", A[15:12], A[11:8], A[7:4], A[3:0], $signed(A));
    $display("B:   %b_%b_%b_%b  signed: %d", B[15:12], B[11:8], B[7:4], B[3:0], $signed(B));
    $display("Y: %b_%b_%b_%b_%b  signed: %d", overflow, Y[15:12], Y[11:8], Y[7:4], Y[3:0], $signed(Y));


    #5 $finish;

  end    

  CSA tb0(A, B, mod, Y, overflow);

endmodule
