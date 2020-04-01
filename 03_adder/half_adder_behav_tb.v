`timescale 1ns/100ps

module half_adder_behav_tb();

  reg     t_a;
  reg     t_b;
  wire    t_sum;
  wire    t_cout;

  half_adder_behav dut ( 
    .a    ( t_a    ), 
    .b    ( t_b    ), 
    .sum  ( t_sum  ), 
    .cout ( t_cout ) 
  );

  initial begin
            t_a = 0; t_b = 0;
    #20     t_a = 1; t_b = 0;
    #20     t_a = 1; t_b = 1;
    #20     $finish;
  end

endmodule