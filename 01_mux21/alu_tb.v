
`timescale 1ns/100ps

module alu_tb();

  reg [3:0] t_op1,t_op2;
  reg [1:0] t_opcode;
  wire [3:0] t_y;

  alu dut ( .op1(t_op1), .op2(t_op2), 
            .opcode(t_opcode),
            .y(t_y));

  initial begin
    t_op1 = 4'h5; t_op2 = 4'h8; t_opcode = 2'b00;
    #100;
    t_op1 = 4'ha; t_op2 = 4'h8; t_opcode = 2'b01;
    #100;
    t_op1 = 4'ha; t_op2 = 4'h8; t_opcode = 2'b10;
    #100;
    t_op1 = 4'ha; t_op2 = 4'h8; t_opcode = 2'b11;
    #100;
    $stop;
  end

endmodule

