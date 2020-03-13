
`timescale 1ns/100ps

module freq_div_led8_pipe (
                           reset_n,
                           clock,
                           datain,
                           diode
                          );

   input              reset_n;
   input              clock;
   input  [7:0]       datain;
   output [7:0]       diode;

   // wire   [7:0]       diode;

   wire              clockout;

   led8_pipe led8_pipe (
      .reset_n(reset_n),
      .clock(clockout),
      .diode(diode)
   );

   freq_div freq_div (
      .reset_n(reset_n),
      .clockin(clock),
      .datain(datain),
      .clockout(clockout)
   );

endmodule
