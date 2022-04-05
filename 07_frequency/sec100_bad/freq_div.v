module freq_div ( clk_50MHz, clr, clk_1Hz ); 
output  clk_1Hz;
input    clk_50MHz, clr; 
reg               clk_1Hz;
reg    [25:0]  count;
parameter  count_width = 49_999_999,
                    half_width = 24_999_999;
always @ ( posedge clk_50MHz ) begin
      if ( clr ) begin
           count   <= 26'h000_0000;
      end
      else if ( count == count_width ) begin 
           count   <= 26'h000_0000;
      end
      else begin
           count   <= count + 26'h000_0001;
      end
end
always @ ( posedge clk_50MHz ) begin
      if ( clr ) begin
           clk_1Hz  <= 1'b0;
      end
      else if ( count == half_width ) begin 
           clk_1Hz   <= 1'b1;
      end
      else if ( count == count_width ) begin
           clk_1Hz   <= 1'b0;
      end
end
endmodule
