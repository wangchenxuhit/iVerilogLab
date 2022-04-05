`timescale 1ns/1ns

module sec100_tb ();

  reg        tb_clk;
  reg        tb_clr;

  wire       tb_cn;
  wire [6:0] tb_high_seg;
  wire [6:0] tb_low_seg;
  parameter delay=64'd40000000000;

  sec100 dut (
    .clk_50MHz ( tb_clk      ), 
    .clr       ( tb_clr      ), 
    .high_seg  ( tb_high_seg ),
    .low_seg   ( tb_low_seg  ),
    .cn        ( tb_cn       )
  );

  initial begin
    tb_clk = 1'b0;
  end

  always #10 tb_clk = ~tb_clk;

  initial begin
        tb_clr = 1'b0;
    #11 tb_clr = 1'b1;
    #25 tb_clr = 1'b0;
    #delay $finish;
  end

endmodule

