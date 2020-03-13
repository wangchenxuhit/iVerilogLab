//
// mux21_tb.v
//
`timescale 1ns/100ps

module mux21_tb;

reg                 tb_a;
reg                 tb_b;
reg                 tb_sel;
wire                tb_out; 

mux21 dut (
  .a   ( tb_a   ),
  .b   ( tb_b   ),
  .sel ( tb_sel ),
  .out ( tb_out )
);

initial begin
  tb_a   = 1'b0;
  tb_b   = 1'b1;
  tb_sel = 1'b1;
  #10;
  tb_a   = 1'b1;
  tb_b   = 1'b0;
  tb_sel = 1'b1;
  #10;
  tb_a   = 1'b1;
  tb_b   = 1'b0;
  tb_sel = 1'b0;
  #10;
  $finish;
end

endmodule

