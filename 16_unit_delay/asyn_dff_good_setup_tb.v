//
// Asynchronous reset DFF testbench file
//

`timescale 1ns/100ps
//`define USE_NEGEDGE

module asyn_dff_good_setup_tb();

  reg     t_clk;
  reg     t_rst;
  reg     t_d;
  wire    t_asyn_q;  

  // Asynchronous DFF
  asyn_dff  dut ( 
    .clk ( t_clk    ), 
    .rst ( t_rst    ), 
    .d   ( t_d      ), 
    .q   ( t_asyn_q ) 
  );

  //
  // Produce the clock
  //
  initial begin
    t_clk = 0;
  end
  always #20 t_clk = ~t_clk;

  //
  // Generates a reset signal and the rising edge is effective
  //
  initial begin
    t_rst = 0;
    #10;
    t_rst = 1;
    #20;
    t_rst = 0;
  end

  //
  // Control signal
  //
  initial begin
    t_d = 1;          
    @( posedge t_clk) #1;      
    t_d = 0; 
    @( posedge t_clk) #1;      
    t_d = 1;         
    @( posedge t_clk) #1;      
    t_d = 0;      
    @( posedge t_clk) #1;      
    t_d = 1;    
    @( posedge t_clk) #1;      
    t_d = 0;    
    @( posedge t_clk) #1;      
    t_d = 1; 
    @( posedge t_clk) #1;      
    $finish;
    /*
    @( negedge t_clk);      
    t_d = 0; 
    @( negedge t_clk);      
    t_d = 1;         
    @( negedge t_clk);      
    t_d = 0;      
    @( negedge t_clk);      
    t_d = 1;         
    @( negedge t_clk);      
    t_d = 0;      
    @( negedge t_clk);      
    t_d = 1;         
    @( negedge t_clk);      
    $finish;
    */
  end

endmodule
