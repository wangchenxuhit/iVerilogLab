//
//4 leds pipe testbench design
//

`timescale 1ns/100ps

module led4_pipe_tb();

  reg        t_clk;
  reg        t_reset_n;
  wire [3:0] t_diode;  

  led4_pipe  dut ( 
    .clock   ( t_clk     ), 
    .reset_n ( t_reset_n ), 
    .diode   ( t_diode   ) 
  );

  //Produce the clock
  initial begin
    t_clk = 0;
  end
  always #20 t_clk = ~t_clk;

  //Generates a reset signal and the falling edge is effective
  initial begin
    t_reset_n = 1;
    #10;
    t_reset_n = 0;
    #20;
    t_reset_n = 1;
  end

endmodule
