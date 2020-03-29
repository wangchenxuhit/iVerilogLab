/*
**bidirectional universal shift register
*/

`timescale 1ns/100ps

module s74194_tb();

    reg        t_clk, t_rst, t_sin;
    reg  [1:0] t_mode;
    reg  [7:0] t_pin;
    wire       t_sout;  
    wire [7:0] t_pout;

    s74194  dut ( .clk (t_clk),  .rst (t_rst), .sin(t_sin), .mode(t_mode), .pin(t_pin), 
                  .sout(t_sout), .pout(t_pout) );

    //Produce the clock
    initial begin
        t_clk = 0;
    end
    always #10 t_clk = ~t_clk;

    //Generates a reset signal and the rising edge is effective
    initial begin
        t_rst = 0;
        #8;
        t_rst = 1;
        #10;
        t_rst = 0;
    end

    //t_sin
    initial begin
                 t_sin = 1; 
    end    
    always #12 t_sin = ~t_sin;

    //t_mode
    initial begin
                 t_mode = 2'b01; 
        #85      t_mode = 2'b10; 
        #80      t_mode = 2'b00;         
        #80      t_mode = 2'b11;
        #80     $finish; 
    end
    
    //t_pin
    initial begin
                 t_pin = 8'h1A; 
        #25      t_pin = 8'h2B; 
        #25      t_pin = 8'h3C;         
        #25      t_pin = 8'h35;      
        #25      t_pin = 8'h18;    
        #25      t_pin = 8'h1;     
        #25      t_pin = 8'h13;    
        #25      t_pin = 8'h29;    
        #25      t_pin = 8'h2F;    
        #25      t_pin = 8'h39;    
        #25      t_pin = 8'h19;   
        #30      t_pin = 8'h10; 
    end

endmodule