//
//sync testbench files
//

`timescale 1ns/100ps

module sync_tb();

  reg     t_clk；
  reg     t_d;
  wire    t_dout;  

  sync  dut ( 
    .clock ( t_clk  ), 
    .d     ( t_d    ), 
    .dout  ( t_dout ) 
  );

  //Produce the clock
  initial begin
      t_clk = 0;
  end
  always #20 t_clk = ~t_clk;

  //Control signal
  initial begin
             t_d = 1; 
    #25      t_d = 0; 
    #25      t_d = 1; 
    #25      t_d = 0; 
    #2       t_d = 1; 
    #3       t_d = 0; 
    #2       t_d = 1; 
    #5       t_d = 0; 
    #15      t_d = 1;         
    #25      t_d = 0;      
    #25      t_d = 1;    
    #25      t_d = 0;    
    #30      t_d = 1; 
    #20     $finish;
  end

endmodule
