module alu(op1,op2,opcode,y);
  input [3:0] op1,op2;
  input [1:0] opcode;
  output[3:0] y;
  reg   [3:0] y;
  always @(op1 or op2 or opcode) begin
    case (opcode)
      2'b00 : y = op1 + op2;
      2'b01 : y = op1 - op2;
      2'b10 : y = op1 & op2;
      2'b11 : y = op1 ^ op2;
    endcase
  end
endmodule

