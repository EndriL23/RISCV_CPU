`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/27/2026 09:40:51 PM
// Design Name: 
// Module Name: tb_ALU
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


module tb_ALU;

logic [31:0] a;
logic [31:0] b;
logic [3:0] alu_control;
logic [31:0] result;
logic zero;
logic negative;
logic overflow;

ALU dut (
    .a(a),
    .b(b),
    .alu_control(alu_control),
    .result(result),
    .zero(zero),
    .negative(negative),
    .overflow(overflow)
);

initial begin
    a = 32'h7000_0001;
    b = 32'h7000_1101;
    alu_control = 4'b1000; // ADD

    #10; // let the ALU respond

    $display("result=%0d zero=%b negative=%b overflow=%b",
             result, zero, negative, overflow);

    $finish;
end

endmodule
