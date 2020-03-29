module sync (
                  clock,
                  d,
                  dout
                 );

   input             clock;
   input             d;
   output            dout;

   reg               q1;
   reg               q2;

   always @( posedge clock ) begin
       q1 <= d;
       q2 <= q1;
   end

   assign dout = q2;

endmodule
