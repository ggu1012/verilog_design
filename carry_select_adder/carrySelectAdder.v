module CSA(
    input [15:0] A,
    input [15:0] B,
    input mod, // 0:adder, 1:subtractor
    output [15:0] Y,
    output overflow
  );

  // X is used to save the modification of B for adder/subtractor.
  wire [15:0] X;

  /* These two registers are used for saving two
  	 results, induced by different carry-in, of adder. 
     4 bit of each wire is allocated for one 4-bit adder.
  */
  wire [15:0] carryzero;
  wire [15:0] carryone;

  /* 8 wires are used for saving carryout result of adders
  */
  wire c0_0, c0_1;
  wire c1_0, c1_1;
  wire c2_0, c2_1;
  wire c3_0, c3_1;

  /* 3 wires for propagating each carryout of 4-bit block*/
  wire c0, c1, c2;

  wire [3:0] A0 = A[3:0];
  wire [3:0] A1 = A[7:4];
  wire [3:0] A2 = A[11:8];
  wire [3:0] A3 = A[15:12];
  // A[15:0] = {A3, A2, A1, A0}

  wire [3:0] X0 = X[3:0];
  wire [3:0] X1 = X[7:4];
  wire [3:0] X2 = X[11:8];
  wire [3:0] X3 = X[15:12];
  // X[15:0] = {X3, X2, X1, X0}

  // mod=1 chooses B for subtractor.
  mux16 s0(B, ~B, mod, X);

  fourBitAdder zero_0(A0, X0, 1'b0, carryzero[3:0], c0_0);
  fourBitAdder one_0(A0, X0, 1'b1, carryone[3:0], c0_1);
  mux4 m0(carryzero[3:0], carryone[3:0], c0_0, c0_1, mod, Y[3:0], c0);

  fourBitAdder zero_1(A1, X1, 1'b0, carryzero[7:4], c1_0);
  fourBitAdder one_1(A1, X1, 1'b1, carryone[7:4], c1_1);
  mux4 m1(carryzero[7:4], carryone[7:4], c1_0, c1_1, c0, Y[7:4], c1);

  fourBitAdder zero_2(A2, X2, 1'b0, carryzero[11:8], c2_0);
  fourBitAdder one_2(A2, X2, 1'b1, carryone[11:8], c2_1);
  mux4 m2(carryzero[11:8], carryone[11:8], c2_0, c2_1, c1, Y[11:8], c2);

  fourBitAdder zero_3(A3, X3, 1'b0, carryzero[15:12], c3_0);
  fourBitAdder one_3(A3, X3, 1'b1, carryone[15:12], c3_1);
  mux4 m3(carryzero[15:12], carryone[15:12], c3_0, c3_1, c2, Y[15:12], overflow);

endmodule
