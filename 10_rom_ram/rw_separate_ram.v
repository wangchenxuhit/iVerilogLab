
module rw_seperate_ram ( 
    datain, 
    addr, 
    read,
    write,
    dataout 
    );

    input   [3:0]  addr;
    input          read;
    input          write;
    input   [3:0]  datain;
    output  [3:0]  dataout;
    
    reg     [3:0]  memory[0:15];
    
    initial begin
        //Attention:.txt file path should be '/' instead of '\'
        $readmemb("F:/Wang_code/iVerilogLab/10_rom_ram/ram.txt", memory);
    end

    assign dataout = read ? memory[addr] : 4'bzzzz;

    always @( posedge write ) begin
        //Note that this only changes the value of memory, but is not written 
        //to the ram.txt file.To write, please use the $fdisplay() function.
        memory[addr] = datain;
        //Display message in transcript window.
        $display("memory[%d] = %b", addr, memory[addr]);
    end


endmodule
