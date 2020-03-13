module asyn_dff (
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

  always @( posedge clk or posedge rst ) begin
    if ( rst ) begin
      q <= 1'b0;
    end
    else begin
      q <= d;
    end
  end

endmodule

