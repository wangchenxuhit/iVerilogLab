//
//Edge detection testbench file
//

`timescale 1ns/100ps

module edge_detect_tb();

  reg     t_clk；
  reg     t_rst_n；
  reg     t_d;
  wire    t_flag;  

  edge_detect dut ( 
    .clock ( t_clk   ), 
    .rst_n ( t_rst_n ), 
    .din   ( t_d     ), 
    .flag  ( t_flag  ) 
  );

  //Produce the clock
  initial begin
      t_clk = 0;
  end
  always #10 t_clk = ~t_clk;

  //Generates a reset signal and the falling edge is effective
  initial begin
    t_rst_n = 1;
    #8;
    t_rst_n = 0;
    #15;
    t_rst_n = 1;
  end

  //Control signal
  initial begin
             t_d = 0; 
    #15      t_d = 1;         
    #25      t_d = 0;      
    #25      t_d = 1;    
    #25      t_d = 0;    
    #30      t_d = 1; 
    #20     $finish;
  end

endmodule
