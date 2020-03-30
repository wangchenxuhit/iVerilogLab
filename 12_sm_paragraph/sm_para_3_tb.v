//
// 3-paragraph method to describe FSM tsetbench file
//

`timescale 1ns/100ps

module sm_para_3_tb();

  reg     t_clk；
  reg     t_nrst；
  reg     t_i1；
  reg     t_i2;
  wire    t_o1；
  wire    t_o2；
  wire    t_err;  

  // sm_para_3
  sm_para_3 dut ( 
    .clk  ( t_clk  ), 
    .nrst ( t_nrst ), 
    .i1   ( t_i1   ), 
    .i2   ( t_i2   ), 
    .o1   ( t_o1   ), 
    .o2   ( t_o2   ), 
    .err  ( t_err  ) 
  );

  //Produce the clock
  initial begin
    t_clk = 0;
  end
  always #10 t_clk = ~t_clk;

  //Generates a reset signal and the falling edge is effective
  initial begin
    t_nrst = 1;
    @( posedge t_clk );
    t_nrst = 0;
    @( posedge t_clk );
    t_nrst = 1;
  end

  //Control signal
  initial begin
             t_i1 = 1; t_i2 = 0;
    #20                        ;
    #12      t_i1 = 1; t_i2 = 1; 
    #12      t_i1 = 0; t_i2 = 1;         
    #12      t_i1 = 1; t_i2 = 1;      
    #12      t_i1 = 1; t_i2 = 1;    
    #12      t_i1 = 1; t_i2 = 1;    
    #12      t_i1 = 0; t_i2 = 1;   
    #12      t_i1 = 1; t_i2 = 0;   
    #12      t_i1 = 0; t_i2 = 0;         
    #12      t_i1 = 1; t_i2 = 1;      
    #12      t_i1 = 1; t_i2 = 0; 
    #12     $finish;
  end

endmodule
