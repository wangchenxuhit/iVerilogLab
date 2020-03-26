
module cnt16 ( 
  clk, 
  rst_n, 
  cnt 
);
  input          clk;
  input          rst_n;
  output  [3:0]  cnt;
  
  reg     [3:0]  cnt;
  always @( posedge clk or negedge rst_n ) begin 
    if ( ~rst_n ) begin
      cnt    <= 4'b0000;          
    end
    else if ( &cnt ) begin
      cnt    <= 4'b0000;
    end
    else begin
      cnt    <=  cnt + 4'b0001;         
    end
  end

endmodule
