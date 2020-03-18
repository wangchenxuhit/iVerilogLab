module cnt16_tb ();
  reg   tb_clk;
  reg   tb_rst_n;

  cnt16 dut (
    .clk  ( tb_clk  ), 
    .rst_n( tb_rst_n), 
    .cnt  ( tb_cnt  )
  );

  initial begin
    tb_clk = 1'b0;
  end

  always #10 tb_clk = ~tb_clk;

  initial begin
        tb_rst_n = 1'b1;
    #11 tb_rst_n = 1'b0;
    #25 tb_rst_n = 1'b1;
    #100 $finish;
  end

endmodule

/*
module cnt16_tb ();
reg              tb_clk, tb_rst_n;
reg              tb_clk, tb_rst_n;
cnt16 dut 
(.clk(tb_clk), .rst_n(tb_rst_n), cnt(tb_cnt));
initial begin
      tb_clk = 1¡¯b0;
end
always #10 tb_clk = ~tb_clk;
initial begin
      tb_rst_n = 1¡¯b1;
      #11 tb_rst_n = 1¡¯b0;
      #25 tb_rst_n = 1¡¯b1;
      #100 $finish;
end
endmodule
*/

