//
// mux21.v
//
`timescale 1ns/100ps

module mux21 ( 
  out,
  a,
  b,
  sel
);

input               a;
input               b;
input               sel;
output              out;



//
// MUX21 output
//
reg                 out;
always @( sel or a or b )  begin 
  if ( !sel ) begin
    out = a;
  end
  else begin
    out = b;
  end
end

endmodule



