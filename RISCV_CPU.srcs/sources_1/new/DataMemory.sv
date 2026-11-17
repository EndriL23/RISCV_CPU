`timescale 1ns / 1ps


module DataMemory #(

    parameter DEPTH = 256,
    parameter DW = 32
)(

    input  logic clk,
    input  logic we,
    input  logic [31:0] wd,
    input  logic [31:0] addr,
    output logic [31:0] rd
);

    reg [DW-1:0] mem [0:DEPTH-1];

    wire [$clog2(DEPTH)-1:0] word_index = addr[$clog2(DEPTH)+1:2];

    assign rd = mem[word_index];

    always_ff @(posedge clk) begin
        if (we) begin
            mem[word_index] <= wd;
        end
    end


endmodule
