`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 01:13:51 PM
// Design Name: 
// Module Name: tb_ProgramCounter
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module tb_ProgramCounter;

logic clk;
logic rst;
logic [31:0] pc_next;
logic [31:0] pc;

    
    ProgramCounter inst0 (
    .clk(clk),
    .rst(rst),
    .pc_next(pc_next),
    .pc(pc)
    
);
    initial begin
    clk = 0;
    forever #5 clk = ~clk;
    end
    
    initial begin
    rst = 1;
    forever #30 rst = ~rst;
    end
    
    assign pc_next = pc + 4;
    

endmodule
