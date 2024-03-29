module freq_bcd ( high, low, cn, clr, clk_50MHz );
output [3:0] high, low;    // high: 高4位输出
                                          // low  : 低4位输出
output          cn;               // 高4位的进位
input            clr, clk_50MHz;
reg       [3:0] high, low;
reg                cn;
reg                clk_1Hz;
reg    [25:0]  count;
parameter    count_width = 49_999_999,
                      half_width    = 24_999_999;
always @ ( posedge clk_50MHz ) begin
      if ( clr ) begin
           count   <= 26’h000_0000;
      end
      else if ( count == count_width ) begin 
           count   <= 26’h000_0000;
      end
      else begin
           count   <= count + 23’h000_0001;
      end
end
always @ ( posedge clk_50MHz ) begin
      if ( clr ) begin
           clk_1Hz  <= 1’b0;
      end
      else if ( count == half_width ) begin 
           clk_1Hz   <= 1’b1;
      end
      else if ( count == count_width ) begin
           clk_1Hz   <= 1’b0;
      end
end
always @ ( posedge clk_1Hz or posedge clr ) begin 
      if ( clr ) begin
           cn            <= 0; 
           high[3:0] <= 0;
           low[3:0]  <= 0;
      end
      else begin   // 计数，采用2个if语句的嵌套 
           if ( low[3:0]==9 ) begin                     
	          low[3:0] <= 0;
                 if ( high[3:0] == 9 ) begin
                      high[3:0] <= 0; 
                      cn             <= 1;  
                 end
                 else begin
                      high[3:0] <= high[3:0] + 1;
                 end
            end
            else begin
	           low[3:0]<=low[3:0]+1;cn<=0;
	      end
      end                        
end   	  
endmodule

