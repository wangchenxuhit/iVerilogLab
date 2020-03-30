//
//Edge detection
//

module edge_detect (
  clock,
  rst_n,
  din,
  flag
);

  input             clock;
  input             rst_n;
  input             din;
  output            flag;

   //temp reg
  reg               d1;

  always @( posedge clock or negedge rst_n ) begin
    if(~rst_n) begin
        d1 <= 1'b0;
    end
    else begin
        d1 <= din;
    end
  end

   //detect rising edge 
  assign flag = ( din & ~d1 );
//     //detect falling edge 
//    assign flag = ( ~din & d1 );
//     //detect rising edge & falling edge method1
//    assign flag = ( din & ~d1 ) | ( ~din & d1 );
//     //detect rising edge & falling edge method2
//    assign flag = ( din ^ d1 );

endmodule
