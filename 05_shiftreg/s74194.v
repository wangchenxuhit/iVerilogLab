module s74194 (
  rst,
  clk,
  mode,
  sin,
  pin,
  sout,
  pout
);

  input          rst;
  input          clk;
  input          sin;
  input    [1:0] mode;
  input    [7:0] pin;
  output         sout;
  output   [7:0] pout;

  reg            sout;

  reg      [7:0] pout;
  
  always @( posedge rst or posedge clk )  begin
    if ( rst )  begin
      pout <= 8'b00000000;
    end
    else begin
      case ( mode )
         2'b00 : begin                 // data hold
            pout <= pout;
         end
         2'b01 : begin                 // left shift
            pout[0] <= sin;
            pout[1] <= pout[0];
            pout[2] <= pout[1];
            pout[3] <= pout[2];
            pout[4] <= pout[3];
            pout[5] <= pout[4];
            pout[6] <= pout[5];
            pout[7] <= pout[6];
         end 
         2'b10 : begin                 // right shift
            pout[7] <= sin;
            pout[0] <= pout[1];
            pout[1] <= pout[2];
            pout[2] <= pout[3];
            pout[3] <= pout[4];
            pout[4] <= pout[5];
            pout[5] <= pout[6];
            pout[6] <= pout[7];
         end
         2'b11 : begin                 // paralell load
            pout <= pin;
         end
      endcase    
    end    
  end

  always @( pout or mode )  begin
    case ( mode )
      2'b01 : begin                 // left shift
        sout = pout[7];
      end 
      2'b10 : begin                 // right shift
        sout = pout[0];
      end
      default : begin               // other case
        sout = 1'b0;
      end
    endcase    
  end

endmodule

