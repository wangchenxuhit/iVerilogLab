`timescale 1ns/100ps

module full_adder_tb();

  reg     t_a;
  reg     t_b; 
  reg     t_cin;
  wire    t_sum;
  wire    t_cout;

  full_adder dut ( 
    .a    ( t_a    ), 
    .b    ( t_b    ), 
    .cin  ( t_cin  ), 
    .sum  ( t_sum  ), 
    .cout ( t_cout )
  );

  initial begin
            t_a = 0; t_b = 0; t_cin = 1;
    #20     t_a = 1; t_b = 0; t_cin = 1;
    #20     t_a = 1; t_b = 1; t_cin = 0;
    #20     $finish;
  end

endmodule