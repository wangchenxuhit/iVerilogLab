module shiftreg4 (
  clk,
  rst,
  din,
  dout
);

  input          clk;
  input          rst;
  input          din;
  output         dout;

  wire           dout;
  wire           q0;
  wire           q1;
  wire           q2;

  asyn_dff ff0 (
    .clk(clk),
    .rst(rst),
    .d(din),
    .q(q0)
  );

  asyn_dff ff1 (
    .clk(clk),
    .rst(rst),
    .d(q0),
    .q(q1)
  );

  asyn_dff ff2 (
    .clk(clk),
    .rst(rst),
    .d(q1),
    .q(q2)
  );

  asyn_dff ff3 (
    .clk(clk),
    .rst(rst),
    .d(q2),
    .q(dout)
  );

endmodule

