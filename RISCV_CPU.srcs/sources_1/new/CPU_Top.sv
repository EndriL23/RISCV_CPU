`timescale 1ns / 1ps

module CPU_Top(

input logic clk,
input logic rst
    );
    
wire [31:0] pc;
wire [31:0] pc_next;
wire [31:0] instr;
wire [31:0] imm;
wire alu_src;
wire [3:0] alu_control;
wire [31:0] result;
wire [31:0] rd1;
wire [31:0] rd2;
wire [31:0] alu_b;
wire we;

    
    assign pc_next = pc + 4;
    assign alu_b = alu_src ? imm : rd2;
    
    ProgramCounter inst1 (
    
    .clk(clk),
    .rst(rst),
    .pc(pc),
    .pc_next(pc_next)
    
    );
    
    InstructionMemory inst2 (
    
    .addr(pc),
    .instr(instr)
    
    );   
endmodule
