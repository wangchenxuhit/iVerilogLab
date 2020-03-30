//
//Register with enable signal testbench files
//

`timescale 1ns/100ps

module register1_tb();

  reg     t_clk;
  reg     t_rst;
  reg     t_en;
  reg     t_d;
  wire    t_q;

  register1 dut ( 
    .clk ( t_clk ), 
    .rst ( t_rst ), 
    .en  ( t_en  ), 
    .d   ( t_d   ), 
    .q   ( t_q   ) 
  );

  //Produce the clock
  initial begin
    t_clk = 0;
  end
  always #20 t_clk = ~t_clk;

  //Generates a reset signal and the rising edge is effective
  initial begin
    t_rst = 0;
    #25;
    t_rst = 1;
    #25;
    t_rst = 0;
  end

  //Control signal
  initial begin
            t_en = 1; t_d = 1; 
    #25     t_en = 0; t_d = 0; 
    #15     t_en = 1; t_d = 0;         
    #25     t_en = 0; t_d = 1;      
    #25     t_en = 1; t_d = 1; 
    #20     $finish;
  end

endmodule
