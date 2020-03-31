//
// The testbench for register to register design
//

`timescale 1ns/100ps
//`define USE_NEGEDGE

module reg2reg_w_delay_tb();

  reg          t_clk;
  reg          t_rst;
  reg  [1:0]   t_in;
  wire         t_out;

  reg2reg_w_delay dut ( 
    .clk ( t_clk ), 
    .rst ( t_rst ), 
    .in  ( t_in  ), 
    .out ( t_out ) 
  );

  //
  // Produce the clock
  //
  initial begin
    t_clk = 0;
  end
  always #20 t_clk = ~t_clk;

  //
  // Generates a reset signal and the rising edge is active
  //
  initial begin
    t_rst = 0;
    #25;
    t_rst = 1;
    #25;
    t_rst = 0;
  end

  //
  // Control signal
  //
  initial begin
    t_in = 2'b00; 
    /*
    @( negedge t_clk);      
    t_in = 2'b01; 
    @( negedge t_clk);      
    t_in = 2'b11; 
    @( negedge t_clk);      
    t_in = 2'b10; 
    @( negedge t_clk);      
    t_in = 2'b00; 
    @( negedge t_clk);      
    $finish;
    */
    @( posedge t_clk) #1;      
    t_in = 2'b01; 
    @( posedge t_clk) #1;      
    t_in = 2'b11;         
    @( posedge t_clk) #1;      
    t_in = 2'b10;         
    @( posedge t_clk) #1;      
    t_in = 2'b00;         
    @( posedge t_clk) #1;      
    $finish;
  end

endmodule

