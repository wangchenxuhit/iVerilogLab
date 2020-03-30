
`timescale 1ns/100ps

module dec47 (
   in,
   segment
);
  input  [3:0] in;
  output [6:0] segment;

  reg    [6:0] segment;
  
  always @ ( in ) begin
    case ( in ) 
      4'b0000: segment = 7'b0111111;
      4'b0001: segment = 7'b0000110;
      4'b0010: segment = 7'b1011011;
      4'b0011: segment = 7'b1001111;
      4'b0100: segment = 7'b1100110;
      4'b0101: segment = 7'b1101101;
      4'b0110: segment = 7'b1111101;
      4'b0111: segment = 7'b0000111;
      4'b1000: segment = 7'b1111111;
      4'b1001: segment = 7'b1101111;
      4'b1010: segment = 7'b1110111;
      4'b1011: segment = 7'b1111100;
      4'b1100: segment = 7'b0111001;
      4'b1101: segment = 7'b1011110;
      4'b1110: segment = 7'b1111001;
      4'b1111: segment = 7'b1110001;
     endcase
  end

endmodule
                         
