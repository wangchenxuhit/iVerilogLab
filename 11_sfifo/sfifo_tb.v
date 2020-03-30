// include
`include "sfifo_def.v"

module sfifo_tb();

  reg                            clock;
  reg                            clr_n;
  reg   [`FIFO_WIDTH - 1:0]    in_data;
  reg                           read_n;
  reg                          write_n;
  wire  [`FIFO_WIDTH - 1:0]   out_data;
  wire                            full;
  wire                           empty;
  wire                            half;
  wire  [`FIFO_BITS:0]          fifo_count;  // Keep track if the  number of bytes in the FIFO

  // Instantiate the counter
  sfifo sfifo(
    .clock   ( clock     ),
    .reset_n ( clr_n     ),
    .data_in ( in_data   ),
    .read_n  ( read_n    ),
    .write_n ( write_n   ),
    .data_out( out_data  ),
    .full    ( full      ),
    .empty   ( empty     ),
    .half    ( half      ),
    .counter ( fifo_count)
  );

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
  end

  initial begin
    clock = 1;
  end

  // Generate the clock
  always #30 clock = ~clock;

  // Initialize inputs
  initial begin
    in_data = 0;
    read_n = 1;
    write_n = 1;

    // Reset the FIFO
    clr_n=1;
    @( negedge clock);
    clr_n = 0;
    @( negedge clock);
    clr_n = 1;

    // Check that the status output are correct  
    if ( empty != 1 ) begin
      $display("\nERROR at time %0t:", $time );
      $display("After reset, empty status not asserted\n" );
      // Use $stop for debugging
      $stop;
    end
    if ( full != 0 )begin
      $display ("\nERROR at time %0t:", $time );
      $display ("After reset,full status is asserted\n");
      // Use $stop for debugging
      $stop;
    end
    if ( half != 0 )begin
      $display( "\nERROR at time %0t:", $time );
      $display ("After reset ,half status is asserted\n");
      // Use $stop for debugging
      $stop;
    end
  end 

  reg                         start_rw;  // start to read/write fifo
  reg                        fast_read;  // Read at high frequency
  reg                       fast_write;  // Write at high frequency
  reg                         cycle_en;  // Count the cycles
  reg   [`FIFO_WIDTH - 1:0]   exp_data;  // The expected data from the FIFO
  reg                      filled_flag;  // The FIFO has filled at least once

  // Initialize internal variables
  initial begin
    start_rw = 0;

    // Write more quickly to the FIFO
    fast_write = 1;
    // Read more slowly from the FIFO
    fast_read = 0;

    cycle_en = 0;
    exp_data = 0;

    filled_flag = 0;

    repeat(10) @( negedge clock );
    start_rw = 1;
  end

  // Increment the cycle count
  always @( negedge clock or negedge clr_n ) begin
    if ( ~clr_n ) begin
      cycle_en = 0;
    end
    else begin
      cycle_en = cycle_en + 1;
    end
  end

  // READ operation
  // Check whether to assert read_n
  // Do not read the FIFO if it is empty
  always @( negedge clock or negedge clr_n ) begin
    if ( ~clr_n ) begin
      read_n <= 1;
      exp_data <= 0;
    end
    // Check the read data
    else if ( start_rw && ( ( fast_read || cycle_en ) && ~empty ) ) begin
      read_n <= 0;
      // Increment the expected data
      exp_data <= exp_data + 1;
    end
    else begin
      read_n <= 1;
      exp_data <= exp_data;
    end
  end

  // READ operation
  // Check whether expected data == actual data 
  always @( negedge clock ) begin
    if ( start_rw && ~read_n && ( out_data != exp_data ) ) begin
      $display("\nERROR at time %0t:", $time );
      $display("Expect data out = %h", exp_data );
      $display("Actual data out = %h\n",out_data );
      // Use $stop for debugging
      $stop;
    end
  end

  // WRITE operation
  // Check whether to assert write_n
  // Do not write the FIFO if it is full
  always @( negedge clock or negedge clr_n ) begin
    if ( ~clr_n ) begin
      write_n <= 1;
      in_data <= 0;
    end
    // Check the read data
    else if ( start_rw && ( ( fast_write || cycle_en ) && ~full ) ) begin
      write_n <= 0;
      // Increment the expected data
      in_data <= in_data + 1;
    end
    else begin
      write_n <= 1;
      in_data <= in_data;
    end
  end

  //
  // Complete the simulation
  //
  always @( negedge clock or negedge clr_n ) begin
    // When the FIFO has been filled then emptied.
    // We are done
    if ( filled_flag && empty )begin
      $display("\nSimulation complete - no errors\n");
      $stop;
    end
  end 

  // Analyze the fifo_count
  // Check all of the status signals with each changes of fifo_count
  always @( fifo_count ) begin
    //  Wait a moment to evaluate everything
    #`DEL;
    #`DEL;
    #`DEL;

    case ( fifo_count )
      0 : begin
        if ( ( empty != 1) || (half != 0 ) || ( full != 0 ) ) begin
          $display( "\nERROR at time %0t:", $time );
          $display( "fifo_count = %h", fifo_count );
          $display( "empty = %b", empty);
          $display( "half = %b",half);
          $display( "full = %b\n",full);
          // Use $stop for debugging
          $stop;
        end
        if ( filled_flag == 1 ) begin
          // The FIFO has filled and emptied 
          $display("\nSimulation complete - no error\n");
          $stop;
        end
      end // 0

      `FIFO_HALF : begin
        if ( ( empty != 0 ) || ( half != 1 ) || ( full != 0 ) ) begin
          $display("\nERROR at time %0t:", $time);
          $display("fifo_count = %h", fifo_count);
          $display("empty = %b", empty);
          $display("half = %b", half);
          $display("full = %b\n",full);
          // Use $stop for debugging
          $stop;
        end
      end // FIFO_HALF

      `FIFO_DEPTH : begin
        if ( ( empty != 0) || (half != 1 ) || ( full != 1 ) ) begin
          $display("\nERROR at time %0t:", $time);
          $display("fifo_count = %h", fifo_count);
          $display("empty = %b",empty);
          $display("half = %b",half);
          $display("full = %b", full);
          // Use $stop for debugging
          $stop;
        end
        // The FIFO has filled, so set the flag filled_flag = 1;
        filled_flag = 1;
        // Once the FIFO has filled, empty it
        // write slowly to the FIFO
        fast_write = 0;
        // read quickly from the FIFO
        fast_read = 1;
      end // FIFO_DEPTH

      default: begin
        if ( ( empty != 0) || ( full != 0 ) ) begin
          $display("\nERROR at time %0t:", $time);
          $display("fifo_count = %h", fifo_count);
          $display("empty = %b",empty);
          $display("half = %b",half);
          $display("full = %b\n",full);
          // Use $stop for debugging
          $stop;
        end
        if ( ( ( fifo_count < `FIFO_HALF ) && ( half == 1 ) ) || 
             ( ( fifo_count >= `FIFO_HALF ) && ( half == 0 ) ) 
           ) begin
          $display("\nERROR at time %0t:", $time);
          $display("fifo_count = %h",fifo_count);
          $display("empty = %b", empty);
          $display("half = %b", half);
          $display("full = %b\n",full);
          // Use $stop for debugging
          $stop;
        end 
      end // default
    endcase
  end // always

endmodule // sfifo_tb

