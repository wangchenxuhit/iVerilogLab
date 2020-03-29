
`timescale 1ns/100ps

/*
**While datain = 5, this file will achieve 10 frequency division
*/

`timescale 1ns/100ps

module freq_div (
                 reset_n,
                 clockin,
                 datain,
                 clockout
                );

   input             reset_n;
   input             clockin;
   input  [7:0]      datain;
   output            clockout;

   reg               clockout;

   reg    [7:0]      counter;
   
   always @( posedge clockin or negedge reset_n ) begin
      if ( ~reset_n ) begin
         counter <= 8'h00; 
      end
      else if ( ~|counter ) begin
         //Attention:You should subtract one from datain, otherwise it will become 2*(datain + 1) frequency division
         //Not counter <= datain;
         counter <= datain - 8'h01;        
      end
      else begin
         counter <= counter - 8'h01;
      end
   end

   //
   // If we use the carry out as clock out, duty cycle is not 50%.
   //
   // wire     cout;
   // assign   cout = (counter == 8'hff);
   //

   //
   // If we use the following clockout as clock out, duty cycle is 50%.
   // However, we must know the following code has included 2-div 
   // frequence. 
   //
   always @( posedge clockin or negedge reset_n ) begin
      if ( ~reset_n ) begin
         clockout <= 1'b0; 
      end
      else if ( ~|counter ) begin
         clockout <= ~clockout; 
      end
   end

endmodule
