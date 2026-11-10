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
    
    InstructionMemory fetch (
    
    .addr(pc),
    .instr(instr)
    
    );
    
    ControlUnit decoder (
    
    .opcode(instr[6:0]),
    .funct3(instr[14:12]),
    .funct7(instr[31:25]),
    .we(we),
    .alu_src(alu_src),
    .alu_control(alu_control)
        
    );
    
    RegisterFile regfile (
    
    .clk(clk),
    .rst(rst),
    .ra1(instr[19:15]),
    .ra2(instr[24:20]),
    .wa(instr[11:7]),
    .rd1(rd1),
    .rd2(rd2),
    .wd(result),
    .we(we)
   
    
    );
    
    ImmediateGenerator imm_ext (
    
    .imm(imm),
    .instr(instr)
    
    );
    
    
    
    
endmodule
