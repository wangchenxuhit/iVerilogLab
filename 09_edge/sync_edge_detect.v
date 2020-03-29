/*
**Sync edge detection
*/

module sync_edge_detect (
                  clock,
                  rst_n,
                  din,
                  flag
                 );

    input             clock;
    input             rst_n;
    input             din;
    output            flag;

    reg               d1;
    reg               d2;

    
    always @( posedge clock or negedge rst_n ) begin
        if(~rst_n) begin
            d1 <= 1'b0;
            d2 <= 1'b0;
        end
        else begin
            d1 <= din;
            d2 <= d1;
        end
    end

    //detect rising edge 
   assign flag = ( d1 & ~d2 );
//     //detect falling edge 
//    assign flag = ( ~d1 & d2 );
//     //detect rising edge & falling edge method1
//    assign flag = ( d1 & ~d2 ) | ( ~d1 & d2 );
//     //detect rising edge & falling edge method2
//    assign flag = ( d1 ^ d2 );

endmodule
