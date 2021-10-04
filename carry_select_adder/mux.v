module mux4(
    input [3:0] in0, in1,
    input carry0, carry1,
    input sel,
    output [3:0] result,
    output carryout
  );

  /*  MUX4 structure
  
                        ---------
    in0[4bit]    ------\         \
    in1[4bit]    ------\         \------ result [4bit]
                       \   MUX4  \
    carry0[1bit] ------\         \------ carryout [1bit]
    carry1[1bit] ------\         \
                        ----------
  */

  assign result = sel? in1: in0;
  assign carryout = sel? carry1: carry0;

endmodule

module mux16(
  input [15:0] in0,
  input [15:0] in1,
  input mod,
  output [15:0] out
);

  /*  MUX16 structure
  
                        ---------
    in0[16bit]   ------\  MUX16  \
    in1[16bit]   ------\         \------ result [16bit]
                        ----------
  */

assign out = mod? in1: in0;


endmodule
