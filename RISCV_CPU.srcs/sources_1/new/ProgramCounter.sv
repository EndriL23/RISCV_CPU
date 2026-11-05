`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/05/2026 12:56:42 PM
// Design Name: 
// Module Name: ProgramCounter
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


module ProgramCounter(

input logic clk,
input logic rst,
input logic [31:0] pc_next,
output logic [31:0] pc

    );
    
    always_ff @(posedge clk) begin
    if (rst) begin
    
    pc <= 32'b0;
    
    end else pc <= pc_next;
end
endmodule
