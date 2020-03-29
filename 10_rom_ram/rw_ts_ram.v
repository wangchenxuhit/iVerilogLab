/*
**Read-write time-sharing multiplexing ram 
*/

module rw_ts_ram ( 
    data, 
    addr, 
    read,
    write,
    );

    input   [3:0]  addr;
    input          read;
    input          write;
    //You can also merge the read signal and the write signal.
    // input          rw;

    //bus
    inout   [3:0]  datain;  
    //memory  
    reg     [3:0]  memory[0:15];
    
    initial begin
        //Attention:.txt file path should be '/' instead of '\'
        $readmemb("F:/Wang_code/iVerilogLab/10_rom_ram/ram.txt", memory);
    end

    //Read from memory onto the data bus
    assign data = read ? memory[addr] : 4'bzzzz;
    //Writes to memory from the bus
    always @( posedge write ) begin
        //Note that this only changes the value of memory, but is not written 
        //to the ram.txt file.To write, please use the $fdisplay() function.
        memory[addr] = data;
        //Display message in transcript window.
        $display("%b",memory[addr]);
    end

    /***************************************************************************/
    // //If define rw
    // //Read from memory onto the data bus
    // assign data = rw ? memory[addr] : 4'bz;
    // //Writes to memory from the bus
    // always @( negedge rw ) begin
    //     memory[addr] = data;
    // end


endmodule
