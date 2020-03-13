module syn_dff (
  clk,
  rst,
  d,
  q
);

  input    clk;
  input    rst;
  input    d;
  output   q;

  reg      q;

  always @( posedge clk ) begin
    if ( rst ) begin
      q <= 1'b0;
    end
    else begin
      q <= d;
    end
  end

endmodule

