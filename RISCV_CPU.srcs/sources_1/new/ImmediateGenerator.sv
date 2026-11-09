`timescale 1ns / 1ps


module ImmediateGenerator(

input logic [31:0] instr,
output logic [31:0] imm  //sign extension of the immediate to 32 bits
    
    );
    
    always_comb begin
     if (instr[31] == 1) begin
     imm = {{20{instr[31]}}, instr[31:20]};
     end
     
     else if (instr[31] == 0) begin
     imm = {{20{instr[31]}}, instr[31:20]};
     end
     
     else begin 
     imm = 32'bx;
     end
           
end    
endmodule
