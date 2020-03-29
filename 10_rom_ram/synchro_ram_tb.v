/*
**Read and write seperately ram testbench files
*/

`timescale 1ns/100ps

module rw_seperate_ram_tb();

    reg     [3:0] t_datain;
    reg     [3:0] t_addr;
    reg           t_read;
    reg           t_write;
    wire    [3:0] t_dataout;  

    rw_seperate_ram  dut ( .datain(t_datain), .addr(t_addr), .read(t_read), .write(t_write), .dataout(t_dataout) );

    //Generates the read and write signal
    initial begin
                t_read = 1; t_write = 0;
        #12     t_read = 0; t_write = 0;
        #12     t_read = 1; t_write = 0;
        #12     t_read = 0; t_write = 0;
        #12     t_read = 1; t_write = 0;
        #12     t_read = 0; t_write = 0;
        #12     t_read = 0; t_write = 1;
        #12     t_read = 0; t_write = 0;
    end

    //Generates the input data
    initial begin
        t_datain = 4'h4;
        #12;
        t_datain = 4'h6;
        #12;
        t_datain = 4'h1;
        #12;
        t_datain = 4'hA;
        #12;
        t_datain = 4'hF;
        #12;
        t_datain = 4'h0;
    end

    //Memory address
    initial begin
                t_addr = 4'h2;
        #10     t_addr = 4'h3;
        #10     t_addr = 4'hA;
        #10     t_addr = 4'hF;
        #10     t_addr = 4'h1;
        #10     t_addr = 4'h6;
        #10     t_addr = 4'hB;
        #50     $finish;
    end

endmodule