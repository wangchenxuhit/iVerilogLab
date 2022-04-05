module bcd_cnt (
  high, 
  low, 
  cn, 
  clr, 
  clk 
);

output [3:0] high;   // high����4λ���
output [3:0] low;    // low ����4λ���
output       cn;     // ��4λ�Ľ�λ
input        clr, clk;
reg    [3:0] high, low;
reg          cn;

always @(posedge clk or posedge clr) begin 
  if ( clr ) begin
    cn        <= 0; 
    high[3:0] <= 0;
    low[3:0]  <= 0;
  end
  else begin   // ����������2��if����Ƕ�� 
    if ( low[3:0]==9 ) begin                     
      low[3:0] <= 0;
      if ( high[3:0] == 9 ) begin
        high[3:0] <= 0; 
        cn        <= 1;  
      end
      else begin
        high[3:0] <= high[3:0] + 1;
      end
    end
    else begin
      low[3:0]<= low[3:0]+1;
      cn      <= 0;
    end
  end                        
end   	  

endmodule 

