module sec100 ( clk_50MHz, clr, cn, 
                            high_seg, low_seg );
output [6:0] high_seg, low_seg; 
output          cn; 
input            clk_50MHz, clr;

wire              clk_1Hz;
wire     [3:0] high_temp, low_temp;
 
freq_div freq_div ( 
      .clk_50MHz( clk_50MHz ), 
      .clr               ( clr                 ), 
      .clk_1Hz      ( clk_1Hz        )
);

bcd_cnt bcd_cnt ( 
       .high  ( high_temp ), 
       .low    ( low_temp  ), 
       .cn      ( cn               ), 
       .clr      ( clr              ), 
       .clk      ( clk_1Hz             )
); 

decoder47 dec47_high ( 
        .segment ( high_seg   ), 
        .in      ( high_temp )
);

decoder47 dec47_low ( 
        .segment ( low_seg   ), 
        .in      ( low_temp )
);

endmodule

