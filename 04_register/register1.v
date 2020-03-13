module register1 (
  clk,
  rst,
  en,
  d,
  q
);

  input    clk;
  input    rst;
  input    en;
  input    d;
  output   q;

  reg      q;

  always @( posedge clk or posedge rst ) begin
    if ( rst ) begin
      q <= 1'b0;
    end
    else if ( en ) begin
      q <= d;
    end
    else begin
      q <= q;
    end
  end

endmodule

