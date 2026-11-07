`timescale 1ns / 1ps


module InstructionMemory #(

parameter DEPTH = 256,
parameter DW = 32

)(

input logic [DW - 1:0] addr,   // address
output logic [DW - 1:0] instr  //instruction

    );
    
    reg [DW - 1:0] storage [0:DEPTH - 1];    //storage width and rows
    
    
    initial begin
    $readmemh("program.mem", storage);       
    end
    
    assign instr = storage[addr[$clog2(DEPTH) + 1:2]];
    
endmodule
