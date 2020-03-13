module led8_pipe (
                  reset_n,
                  clock,
                  diode
                 );

   input             reset_n;
   input             clock;
   output [7:0]      diode;

   reg    [7:0]      diode;

   always @( posedge clock or negedge reset_n ) begin
      if ( ~reset_n ) begin
         diode[7:0] <= 8'b0000_0001;
      end
      else begin
         diode[0] <= diode[7];
         diode[1] <= diode[0];
         diode[2] <= diode[1];
         diode[3] <= diode[2];
         diode[4] <= diode[3];
         diode[5] <= diode[4];
         diode[6] <= diode[5];
         diode[7] <= diode[6];
      end
   end

endmodule
