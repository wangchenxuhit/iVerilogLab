
module myrom ( 
  read_addr, 
  read_en, 
  read_data 
);
  input   [3:0]  read_addr;
  input          read_en;
  output  [3:0]  read_data;
  
  reg     [3:0]  read_data;
  reg     [3:0]  mem[0:15];
  
  initial begin
    $readmemb("rom.txt", mem);
  end

  always @( read_addr or read_en ) begin
    if( read_en ) begin
      read_data = mem[read_addr];
    end
  end

endmodule
