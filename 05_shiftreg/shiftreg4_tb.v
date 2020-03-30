//
//Four bits shift reg testbench files
//

`timescale 1ns/100ps

module shiftreg4_tb();

  reg     t_clk;
  reg     t_rst;
  reg     t_din;
  wire    t_dout;  

  shiftreg4  dut ( 
    .clk  ( t_clk  ), 
    .rst  ( t_rst  ), 
    .din  ( t_din  ), 
    .dout ( t_dout ) 
  );

  //Produce the clock
  initial begin
    t_clk = 0;
  end
  always #15 t_clk = ~t_clk;

  //Generates a reset signal and the rising edge is effective
  initial begin
    t_rst = 0;
    #10;
    t_rst = 1;
    #20;
    t_rst = 0;
    #200;
    $finish;
  end

  //Control signal
  initial begin
    t_din = 1; 
  end
  always #12 t_din = ~t_din;

endmodule
