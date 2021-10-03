module adder(
    input a,
    input b,
    input cin,
    output y,
    output cout
  );

  assign y = a + b + cin;
  assign cout = (a & b) + (~a & b & cin) + (a & ~b & cin);

endmodule
