module freqdiv(clk100M,clr,clk1);
  input clr,clk100M;
  output clk1;
  reg clk1;
  reg[23:0] count;
  parameter all=99999999,half=49999999;
  
  always@(posedge clk100M)begin
    if(!clr)begin
      count<=0;
      clk1=1'b0;
    end
    else if(count==half)begin
      count<=count+1'b1;
      clk1<=1'b0;
    end
    else if(count==all)begin
      count<=0;
      clk1<=1'b1;
    end
    else
      count<=count+1'b1;
  end
endmodule
