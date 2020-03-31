module reg2reg_wo_delay (
  clk,
  rst,
  in,
  out
);

  input         clk;
  input         rst;
  input  [1:0]  in;
  output        out;

  reg    [1:0]  tmp1;
  reg           tmp2;
  reg           out;

  always @( posedge clk or posedge rst ) begin
    if ( rst ) begin
      tmp1 <= 2'b00;
    end
    else begin
      tmp1 <= in;
    end
  end

  always @( tmp1 ) begin
    tmp2 = &tmp1;
  end

  always @( posedge clk or posedge rst ) begin
    if ( rst ) begin
      out <= 1'b0;
    end
    else begin
      out <= tmp2;
    end
  end

endmodule

