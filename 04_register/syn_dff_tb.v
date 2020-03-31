//
// Synchronous reset testbench file
//

`timescale 1ns/100ps

module syn_dff_tb();

  reg     t_clk;
  reg     t_rst;
  reg     t_d;
  wire    t_syn_q;  

  //
  // Synchronous DFF
  //
  syn_dff  dut ( 
    .clk ( t_clk    ), 
    .rst ( t_rst    ), 
    .d   ( t_d      ), 
    .q   ( t_syn_q ) 
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
    #25      t_d = 0; 
    #15      t_d = 1;         
    #25      t_d = 0;      
    #25      t_d = 1;    
    #25      t_d = 0;    
    #30      t_d = 1; 
    #20     $finish;
  end

endmodule

