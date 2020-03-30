
module synchro_ram ( 
  clk,
  datain, 
  addr, 
  read,
  write,
  dataout 
);

  input          clk;
  input   [3:0]  addr;
  input          read;
  input          write;
  input   [3:0]  datain;
  output  [3:0]  dataout;
  
  //While asynchronous read,please comment it.
  reg     [3:0]  dataout;
  //Memory 4 bits,16 words.
  reg     [3:0]  memory[0:15];
  
  initial begin
    //Attention:.txt file path should be '/' instead of '\'
    $readmemb("ram.txt", memory);
  end

  // //Asynchronous read
  // assign dataout = read ? memory[addr] : 4'b0000;

  //Synchronous read
  always @( posedge clk ) begin
    if(read) begin
      dataout <= memory[addr];
    end
    else begin
      dataout <= 4'b0000;
    end
  end

  //Synchronous write
  always @( posedge clk ) begin
    if(write) begin
      memory[addr] <= datain;
      //Display message in transcript window.
      $display("%b",memory[addr]);
    end
  end

endmodule
