`include "fullAdder.v"

module fourBitAdder(
    input [3:0] a,
    input [3:0] b,
    input cin,
    output [3:0] y,
    output cout
  );

  ///
  wire cout0;
  wire cout1;
  wire cout2;
  /// temporary wires for carry in one-bit adder

  adder u0(a[0], b[0], cin, y[0], cout0);
  adder u1(a[1], b[1], cout0, y[1], cout1);
  adder u2(a[2], b[2], cout1, y[2], cout2);
  adder u3(a[3], b[3], cout2, y[3], cout);

endmodule
