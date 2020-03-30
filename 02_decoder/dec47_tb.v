
`timescale 1ns/100ps

module dec47_tb();

  reg  [3:0]      t_in;
  wire [6:0]      t_segment;

  dec47 dut ( 
    .in      ( t_in      ), 
    .segment ( t_segment ) 
  );

  initial begin
    t_in = 4'h2;
    #50;
    t_in = 4'h5;
    #50;
    t_in = 4'h8;
    #50;
    t_in = 4'hB;
    #50;
    $finish;
  end

endmodule

