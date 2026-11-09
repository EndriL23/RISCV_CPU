`timescale 1ns / 1ps

module tb_ImmediateGenerator;

logic [31:0] imm;
logic [31:0] instr;

ImmediateGenerator inst0 (
    
    .imm(imm),
    .instr(instr)
);

initial begin
instr = 32'h00500093;
#10;
instr = 32'h00A00113;
#10;
instr = 32'hFFF00093;
#10;
instr = 32'h80000093;
#10;
end

endmodule
