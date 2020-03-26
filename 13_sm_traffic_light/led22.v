
module traffic (
  clk50M,
  rst_n,
  led1,
  led2
);

  input clk,rst_n;
  output[2:0] led1,led2;
  reg[2:0] led1,led2;
  reg[4:0] time_left;
  reg[1:0] state;
  wire clk1h;
  parameter[1:0] s1=2'b00,
                 s2=2'b01,
                 s3=2'b10,
                 s4=2'b11; 
  
  freqdiv dut(
  .clk100M(clk),
  .clr(rst_n),
  .clk1(clk1h)  
  );
  always@(posedge clk1h)begin
    if(!rst_n)begin
      time_left<=5'd18;
      state<=s1;
      led1<=3'b100;
      led2<=3'b001;
    end
    else begin
      case(state)
        s1:begin
          if(time_left==0)begin
            time_left<=5'd2;
            state<=s2;
            led1<=3'b100;
            led2<=3'b001;
          end
          else
            time_left<=time_left-1;
        end
        s2:begin
          if(time_left==0)begin
            time_left<=5'd28;
            state<=s3;
            led1<=3'b100;
            led2<=3'b010;
          end
          else
            time_left<=time_left-1;
        end
        s3:begin
          if(time_left==0)begin
            time_left<=5'd2;
            state<=s4;
            led1<=3'b001;
            led2<=3'b100;
          end
          else
            time_left<=time_left-1;
        end
        s4:begin
          if(time_left==0)begin
            time_left<=5'd18;
            state<=s1;
            led1<=3'b010;
            led2<=3'b100;
          end
          else
            time_left<=time_left-1;
        end
      endcase
    end
  end
endmodule
            
      
      
  
  

