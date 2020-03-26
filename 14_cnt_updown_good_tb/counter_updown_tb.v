/***************************************************************/
//
// FILE NAME: counter_updown_tb.v
//
// CODE TYPE: Simulation
//
// DESCTIPTION: This module provides stimuli for simulating an
//              up/down counter.
//
/***************************************************************/

// DEFINES
`define  DEL 2          // delay

module counter_updown_tb();
  reg              clock;
  reg              reset_n;
  reg              load;
  reg              up_down;
  reg              count_en;
  reg  [7:0]       data_in;

  wire [7:0]       actual_count8;
  wire             actual_carry;

  integer          test_part;       // which part of the test are we doing?
  reg  [7:0]       cycle_count;     // cycle count variable

  reg  [7:0]       expected_count8; // used to compare against the counter
  reg              expected_carry;  // used to compare against the carry

   //
   // INSTANTIATE THE COUNTER
   counter_updown dut (
     .clk       (clock),
     .reset_n   (reset_n),
     .up_down   (up_down),
     .count_en  (count_en),
     .count8    (actual_count8),
     .carry     (actual_carry)
   );

   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end

   //
   // INITIALIZE INPUTS
   initial  begin
     //
     // give all the inputs a certain number
     clock       = 1;
     reset_n     = 1;
     up_down     = 1;
     count_en    = 0;
     // 
     // 1. Verify the reset
     @( posedge clock ) #1;
     @( posedge clock ) #1;
     reset_n     = 0;
     // 
     // Finish the reset
     @( posedge clock ) #1;
     @( posedge clock ) #1;
     reset_n     = 1;
     $display("1. Reset works!");
     // 
     // 2. Start the counter up
     repeat(2) @( posedge clock ) #1;
     count_en    = 1;
     // 
     // 2.1 pause the counter
     repeat(30) @( posedge clock ) #1;
     count_en    = 0;
     // 
     // 2.2 resume the counter
     repeat(3) @( posedge clock ) #1;
     count_en    = 1;
     // 
     // 2.3 stop the counter
     repeat(300) @( posedge clock ) #1;
     count_en    = 0;
     $display("2. Counter works upwards!");
     // 
     // 3. Start the counter up
     repeat(2) @( posedge clock ) #1;
     up_down     = 1;
     repeat(2) @( posedge clock ) #1;
     count_en    = 1;
     // 
     // 3.1 pause the counter
     repeat(30) @( posedge clock ) #1;
     count_en    = 0;
     // 
     // 3.2 resume the counter
     repeat(3) @( posedge clock ) #1;
     count_en    = 1;
     // 
     // 3.3 stop the counter
     repeat(300) @( posedge clock ) #1;
     count_en    = 0;
     $display("3. Counter works downwards!");

     //
     // 4. Finish test
     repeat(30) @( posedge clock ) #1;
     $display("4. Simulation completed, Congratulations!");
     $finish;
   end

   //
   // GENERATE THE CLOCK
   always #50 clock = ~clock;

endmodule // counter_updown_tb

