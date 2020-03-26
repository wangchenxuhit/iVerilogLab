/***************************************************************/
//
// FILE NAME: counter_updown.v
//
// CODE TYPE: RTL Level
//
// DESCRIPTION: This module defines an up/down counter with
// asynchronous reset inputs, and synchronous load,
// up/down control, and count enable.
//
/***************************************************************/
// DEFINES
//
// TOP MODULE
module counter_updown(
               // input clock
               clk,

               // input data
               in,

               // system level reset
               reset_n,

               // load enable
               load,

               // the model of the counter
               up_down,

               // counter enable
               count_en,

               // output data
               count8,
               //  carry bit of the output data
               carry
              );

  // INPUTS
  input               clk;            // Clock
  input [7:0]         in;             // Input
  input               reset_n;        // Active low;
  input               load;           // synchronous load input
  input               up_down;        // synchronous up/down control
  input               count_en;       // synchronous count

  // enable control

  // OUTPUTS
  output [7:0]        count8;          // Output
  output              carry;      // Carry output

  // INOUTS

  // SIGNAL DECLARATIONS
  wire                clk;
  wire [7:0]          in;
  wire                reset_n;
  wire                load;
  wire                up_down;
  wire                count_en;
  wire                carry;

  reg  [7:0]          count8;
  reg                 carry_up;
  reg                 carry_dn;

  // PARAMATERS

  // ASSIGN STATEMENTS
  assign carry = up_down ? carry_up : carry_dn ;

  // MAIN CODE
  // Look at the edge of clock for state transitions
  always @( posedge clk or negedge reset_n ) begin
    if ( ~reset_n ) begin  
      count8    <= 8'h00;
      carry_up <= 1'b0;
      carry_dn <= 1'b1;
    end
    else if ( load ) begin
    // This is implementation, load has priority over count enable
      count8 <= in;
      if ( in == ~8'h00 ) begin 
         carry_up <= 1'b1;
         carry_dn <= 1'b0;
      end
      else if ( in == 8'h00 ) begin
         carry_up <= 1'b0;
         carry_dn <= 1'b1;
      end
      else begin
         carry_up <= 1'b0;
         carry_dn <= 1'b0;
      end
    end
    else if ( count_en ) begin
      if ( up_down ) begin
        count8 <= count8 + 8'h01;
        if ( count8 == ~8'h01 ) begin
            carry_up <= 1'b1;
            carry_dn <= 1'b0;
        end
        else begin
            carry_up <= 1'b0;
            carry_dn <= 1'b0;
        end
      end
      else if ( up_down == 1'b0 ) begin
        count8 <= count8 - 8'h01;
        if ( count8 == 8'h01 ) begin
            carry_up <= 1'b0;
            carry_dn <= 1'b1;
        end
        else begin
            carry_up <= 1'b0;
            carry_dn <= 1'b0;
        end
      end
    end
  end
endmodule // counter
