//
//Rom testbench files
//

`timescale 1ns/100ps

module myrom_tb();

  reg     [3:0] t_read_addr;
  reg           t_read_en;
  wire    [3:0] t_read_data;  

  myrom  dut ( 
    .read_addr ( t_read_addr ), 
    .read_en   ( t_read_en   ), 
    .read_data ( t_read_data ) 
  );

  //Generates the enable signal
  initial begin
    t_read_en = 0;
    #12;
    t_read_en = 1;
    #12;
    t_read_en = 0;
    #12;
    t_read_en = 1;
    #12;
    t_read_en = 0;
    #12;
    t_read_en = 0;
  end

  //Mem address
  initial begin
            t_read_addr = 4'h2;
    #10     t_read_addr = 4'h3;
    #10     t_read_addr = 4'hA;
    #10     t_read_addr = 4'hF;
    #10     t_read_addr = 4'h1;
    #10     t_read_addr = 4'h6;
    #10     t_read_addr = 4'hB;
    #20     $finish;
  end

endmodule
