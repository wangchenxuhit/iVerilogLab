
`timescale 1ns/100ps

module freq_div_led8_pipe_tb ();

   reg                reset_n;
   reg                clock;
   reg    [7:0]       datain;

   wire   [7:0]       diode;

   freq_div_led8_pipe dut (
      .reset_n(reset_n),
      .clock(clock),
      .datain(datain),
      .diode(diode)
   );

   always @( negedge diode[7] ) begin 
      if ( datain == 8'h10 ) begin
         $display("Simulation Completed OK!!!");
         $stop;
      end
   end

   initial begin
      $dumpfile("dump.fsdb");
      $dumpvars();
   end

   initial begin
      clock = 1'b0;
   end

   always #10 clock = ~clock;

   initial begin
      reset_n = 1'b1;
      @(negedge clock) begin
         reset_n = 1'b0;
         datain  = 8'h05;
      end
      repeat(4) begin
         @(negedge clock);
      end
      reset_n = 1'b1;
      repeat(4000) begin
         @(negedge clock);
      end
      datain  = 8'h10;
   end

endmodule
