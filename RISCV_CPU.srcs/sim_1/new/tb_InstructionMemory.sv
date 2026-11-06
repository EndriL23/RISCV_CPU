`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/06/2026 01:09:03 PM
// Design Name: 
// Module Name: tb_InstructionMemory
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


module tb_InstructionMemory;

logic [31:0] addr;
logic [31:0] instr;
parameter DEPTH = 256;

InstructionMemory inst0 (
     .addr(addr),
     .instr(instr)

);
integer i;

 initial begin
 
  for (i = 0; i < DEPTH * 4; i = i + 4) begin
    addr = i;
    #10;
end

end


endmodule
