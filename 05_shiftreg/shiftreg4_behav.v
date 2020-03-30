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

  reg            q0;
  reg            q1;
  reg            q2;
  reg            q3;

  always @( posedge clk ) begin
    if ( rst ) begin
       q3 <= 1'b0;
       q2 <= 1'b0;
       q1 <= 1'b0;
       q0 <= 1'b0;
    end
    else begin
       q3 <= q2;
       q2 <= q1;
       q1 <= q0;
       q0 <= din;
       // { q3, q2, q1, q0 } <=  { q2, q1, q0, din };
    end
  end

  assign dout = q3;

endmodule

/*
//
// The second description method
//
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

  reg  [3:0]     q;

  always @( posedge clk ) begin
    if ( rst ) begin
      q <= 4'b0000;
    end
    else begin
      q <=  { q[2:0], din };
    end
  end

  assign dout = q[3];

endmodule

*/
