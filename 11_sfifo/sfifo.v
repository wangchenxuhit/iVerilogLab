// include, please change the path of sfifo_def.v
`include "F:/Wang_code/iVerilogLab/11_sfifo/sfifo_def.v"

//  TOP MODULE
module  sfifo ( 
  clock,
  reset_n,
  data_in,
  read_n,
  write_n,
  data_out,
  full,
  empty,
  half,
  counter
);

  //INPUTS
  input                     clock;      // input
  input                     reset_n;    // Active low reset
  input [`FIFO_WIDTH-1:0]   data_in;    // Data input to FIFO
  input                     read_n;     // Read FIFO ( active low )
  input                     write_n;    // Write FIFO (avtive low )

  //OUTPUTS
  output [`FIFO_WIDTH-1:0]  data_out;   // FIFO output data
  output                    full;       // FIFO is full
  output                    empty;      // FIFO is half full
  output                    half;       // FIFO is half full or more
  output [`FIFO_BITS:0]     counter;

  //INOUTS


  //SIGNAL DECLARATIONS
  wire                      clock;
  wire                      reset_n;
  wire  [`FIFO_WIDTH-1:0]   data_in;
  wire                      read_n; 
  wire                      write_n;
  reg   [`FIFO_WIDTH-1:0]   data_out;
  wire                      full;
  wire                      empty;
  wire                      half;
  // The FIFOmemory. 
  reg   [`FIFO_WIDTH-1:0] fifo_mem[0:`FIFO_DEPTH-1];  // How many locations in the FIFO are occupied?
  reg   [`FIFO_BITS:0]    counter;  // FIFO read pointer points to the location in the FIFO to read from next
  reg   [`FIFO_BITS-1:0]  rd_pointer;  // FIFO write pointer points to the location in the FIFO to write to next
  reg   [`FIFO_BITS-1:0]  wr_pointer;  

  // ASSIGN STATEMENTS
  assign #`DEL full  = ( counter == `FIFO_DEPTH ) ? 1'b1 : 1'b0;  // FIFO_DEPTH=16
  assign #`DEL empty = ( counter == 0 ) ? 1'b1 : 1'b0;
  assign #`DEL half  = ( counter >= `FIFO_HALF )? 1'b1 : 1'b0;    // FIFO_HALF=8

  //
  // This block contains counter affected by the clock and reset inputs
  //
  always @( posedge clock or negedge reset_n ) begin
    if ( ~reset_n ) begin
      // Reset the FIFO pointer
      counter    <= #`DEL 'b0;
    end 
    else if ( ~read_n && write_n ) begin
      // Check for FIFO underflow
      // Decrement the FIFO counter
      counter <= #`DEL counter - 1;
    end	
    else if ( ~write_n && read_n ) begin
      // Increment teh FIFO counter
      counter <= #`DEL counter + 1;
    end
    else begin
      counter <= counter;
    end
  end
        
  // Increment the read pointer
  // Check if the read pointer has gone beyond the depth of
  // FIFO, so, set it back to the begining of the FIFO	
  always @( posedge clock or negedge reset_n ) begin
    if ( ~reset_n ) begin
      // Reset the FIFO pointer
      rd_pointer <= #`DEL `FIFO_BITS'b0;
    end 
    else if ( ~read_n ) begin
      if ( rd_pointer == `FIFO_DEPTH ) begin
        rd_pointer <= #`DEL `FIFO_BITS'b0; 
      end 
      else begin
        rd_pointer <= #`DEL rd_pointer + 1;
      end 
    end 
    else begin
      rd_pointer <= rd_pointer;
    end 
  end

  // Increment the write pointer
  // Check if the write pointer has gone beyond the depth of
  // FIFO, so, set it back to the begining of the FIFO	
  always @( posedge clock or negedge reset_n ) begin
    if ( ~reset_n ) begin
      // Reset the FIFO pointer
      wr_pointer <= #`DEL `FIFO_BITS'b0;
    end 
    else if ( ~write_n ) begin
      if ( wr_pointer == `FIFO_DEPTH ) begin
        wr_pointer <= #`DEL `FIFO_BITS'b0; 
      end 
      else begin 
        wr_pointer <= #`DEL wr_pointer + 1;
      end
    end
  end 

  // This block contains sfifo read data output 
  always @( posedge clock or negedge reset_n ) begin
    if ( ~reset_n ) begin
      data_out <= #`DEL `FIFO_WIDTH'b0;
    end
    else if ( ~read_n )begin
      // Output the data
      data_out <= #`DEL fifo_mem [ rd_pointer ];
    end
  end

  // sfifo write operation
  always @( posedge clock ) begin
    if ( ~write_n )begin
      // Store the data
      fifo_mem [ wr_pointer ] <= #`DEL data_in; 
    end
  end

  // This block contains all devices affected by the clock but not reset
  always @( posedge clock or negedge reset_n ) begin
    if ( ~reset_n ) begin
      data_out <= #`DEL `FIFO_WIDTH'b0;
    end
    else if ( ~read_n )begin
      // Output the data
      data_out <= #`DEL fifo_mem [ rd_pointer ];
    end
    if ( ~write_n )begin
      // Store the data
      fifo_mem [ wr_pointer ] <= #`DEL data_in; 
    end
  end
endmodule  //sfifo

