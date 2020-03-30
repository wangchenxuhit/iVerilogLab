/***************************************************************/
//
// FILE NAME: counter_updown_tb.v
//
// CODE TYPE: Simulation
//
// DESCTIPTION: This module provides stimuli for simulating an
//              up/down counter.
//              1) It tests the asynchronous rest and the 
//              synchronous load control.
//              2) It loads a value and counts up until the 
//              counter overflows. 
//              3) It then loads a new value and counts 
//              down until the counter overflows. 
//
//              During each cycle, the output is compared to 
//              the expected output.
//
/***************************************************************/

// DEFINES
`define  DEL 2          // delay
`define  PATTERN1 8'h1  // starting data for counting up
`define  PATTERN2 8'h3  // starting data for counting down

// TOP MODULE
module counter_updown_tb();
   // INPUTS

   // OUTPUTS

   // INOUTS

   // SIGNAL DECLARARTIONS
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

   reg  [7:0]       expected_count8;      // used to compare against the counter
   reg              expected_carry;      // used to compare against the carry

   // OUTPUT

   // PARAMETERS

   // ASSIGN STATEMENTS

   // MAIN CODE
   // INSTANTIATE THE COUNTER
   counter_updown dut (
      .clk       ( clock         ),
      .in        ( data_in       ),
      .reset_n   ( reset_n       ),
      .load      ( load          ),
      .up_down   ( up_down       ),
      .count_en  ( count_en      ),
      .count8    ( actual_count8 ),
      .carry     ( actual_carry  )
   );

   initial begin
      $dumpfile("dump.vcd");
      $dumpvars;
   end

   // INITIALIZE INPUTS
   initial  begin
      // give all the inputs a certain number
      clock       = 1;
      data_in     = 8'b0;
      reset_n     = 1;
      load        = 0;
      up_down     = 0;
      count_en    = 0;
      test_part   = 0;        // indicate which part we are doing.
      cycle_count = 8'h00;
      // give all the inputs a certain number
      expected_count8 = 8'h00;
      expected_carry = 1'b0;
   end

   // GENERATE THE CLOCK
   always #50 clock = ~clock;

   // SIMULATE
   always @( negedge clock ) begin
      // Increment the cycle counter
      #`DEL cycle_count = cycle_count + 8'h01;
   end

   always @( negedge clock ) begin
      case ( test_part )
         0 : begin
            case ( cycle_count )
               8'h00 :  begin
                  // assert the reset signal
                  reset_n = 0;
                  // wait for the outputs to change asynchronously
                  # `DEL
                  # `DEL
                  // test output
                  if ( actual_count8 === 8'h0 ) begin
                     $display ( "Reset is working" );
                  end
                  else begin
                     $display ( "\nERROR at time %0t:", $time );
                     $display ( "Reset is not working" );
                     $display ( "actual_count8 = %h\n" , actual_count8 );
                     // use $stop for debugging
                     $stop;
                  end
                  if ( actual_carry === 1'b1 ) begin
                     $display ( "Overflow is working" );
                  end
                  else begin
                     $display ( "\nERROR at time %0t:", $time );
                     $display ( "Overflow is not working" );
                     $display ( "Overflow = %h\n", actual_carry );
                     // use $stop for debugging
                     $stop;
                  end
                  up_down = 1;
                  # `DEL
                  if ( actual_carry === 1'b0 ) begin
                     $display ( "Overflow is working" );
                  end
                  else begin
                     $display ( "\nERROR at time %0t:", $time );
                     $display ( "Overflow is not working" );
                     $display ( "Overflow = %h\n", actual_carry );
                     // use $stop for debugging
                     $stop;
                  end
                  // deassert the reset signal
                  reset_n = 1;
               end
               8'h1 : begin
                  // load data into the counter
                  data_in = `PATTERN1;
                  load    = 1'b1;
               end
               8'h2 : begin
                  // Test outputs
                  if (actual_count8 === `PATTERN1) begin
                     $display ( "Load is working" );
                  end
                  else begin
                     $display ( "\nERROR at time %0t:", $time );
                     $display ( "Load is not working" );
                     $display ( "expected count8 =%h" , `PATTERN1 );
                     $display ( "actual count8 = %h\n" , actual_count8 );
                     // use $stop for debugging
                     $stop;
                  end
                  up_down = 0;
                  # `DEL
                  if ( actual_carry === 1'b0 ) begin
                     $display ( "Overflow is working" );
                  end
                  else begin
                     $display ( "\nERROR at time %0t:", $time );
                     $display ( "Overflow is not working" );
                     $display ( "Overflow = %h\n", actual_carry );
                     // use $stop for debugging
                     $stop;
                  end
                  up_down = 1;
                  # `DEL
                  if ( actual_carry === 1'b0 ) begin
                     $display ( "Overflow is working" );
                  end
                  else begin
                     $display ( "\nERROR at time %0t:", $time );
                     $display ( "Overflow is not working" );
                     $display ( "Overflow = %h\n", actual_carry );
                     // use $stop for debugging
                     $stop;
                  end
                  // deassert the load signal
                  load = 1'b0;
               end
               8'h3 : begin
                  //Test outputs to see that data was not lost
                  if ( actual_count8 === `PATTERN1 ) begin
                     $display ( "Counter hold is working" );
                  end
                  else begin
                     $display ( "\nERROR at time %0t:", $time );
                     $display ( "Counter hold is not working" );
                     $display ( "expected count8 =%h" , `PATTERN1 );
                     $display ( "actual count8 = %h\n" , actual_count8 );
                     // use $stop for debugging
                     $stop;
                  end
                  // count up
                  up_down = 1;
                  count_en = 1'b1;
                  // set the expected outputs
                  expected_count8 = `PATTERN1;
                  expected_carry = 1'b0;
               end
               ~8'h0 : begin
                  // start the second part of the test
                  test_part = 1'b1;
                  count_en = 1'b0;
               end
            endcase
         end
   
         1 : begin
            case (cycle_count)
               // Should consider why start from 8'h2 
               8'h2 : begin
                  // load data into the counter
                  data_in = `PATTERN2;
                  load    = 1'b1;
               end
               8'h3 : begin
                  // Test outputs
                  if ( actual_count8 === `PATTERN2 )  begin
                     $display ("Load is working");
                  end
                  else begin
                     $display ( "\nERROR at time %0t:" , $time );
                     $display ( "Load is not working" );
                     $display ( "expected count8 =%h" , `PATTERN2 );
                     $display ( "actual count8 = %h\n" , actual_count8 );
                     // use $stop for debugging
                     $stop;
                  end
                  // count down
                  count_en = 1'b1;
                  up_down  = 1'b0;
                  load     = 1'b0;
                  // set the expected outputs
                  expected_count8 = `PATTERN2;
               end
               ~8'h0 : begin
                  // start the third part of the test
                  test_part = 2; 
               end
            endcase
         end

         2 : begin
            case ( cycle_count )
               8'h0 : begin
                  $display( "\nSimulation Completed - No errors\n" );
                  $finish;
               end
            endcase
         end
      endcase

      // Test the counter output
      if ( ( count_en ) && ( actual_count8 !== expected_count8 ) )  begin
         $display ( "\nERROR at time %0t:", $time );
         $display ( "Count is incorrect" );
         $display ( "expected count8 = %h" , expected_count8 );
         $display ( "actual count8 = %h\n" , actual_count8 );
         //use $stop for debugging
         $stop;
      end

      // Test the Overflow if we are counting
      if (( count_en ) && ( actual_carry !== expected_carry )) begin
         $display ( "\nERROR at time %0t:" , $time );
         $display ( "Carry out is incorrect" );
         $display ( "expected carry = %h" , expected_carry );
         $display ( "actual carry = %h\n" , actual_carry );
         // use $stop for debugging
         $stop;
      end

      // Determine the expected outputs for the next cycle
      if ( up_down === 1'b1 )  begin
         if ( count_en === 1'b1 ) begin
            expected_count8 = expected_count8 + 8'h1;
            if ( expected_count8 === ~8'h0 ) begin
               expected_carry = 1'b1;
            end
            else begin
               expected_carry = 1'b0;
            end
         end
      end
      else if ( up_down === 1'b0 ) begin
         if ( count_en === 1'b1 ) begin
            expected_count8 = expected_count8 - 8'h1;
            if ( expected_count8 === 8'h0 ) begin
               expected_carry = 1'b1;
            end
            else begin
               expected_carry = 1'b0;
            end
         end
      end

   end

endmodule // counter_updown_tb
