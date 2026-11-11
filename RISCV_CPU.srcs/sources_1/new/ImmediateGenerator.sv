`timescale 1ns / 1ps


module ImmediateGenerator(

input logic [31:0] instr,
output logic [31:0] imm  //sign extension of the immediate to 32 bits
    
    );
    
      localparam OP_LUI   = 7'b0110111;
      localparam OP_AUIPC = 7'b0010111;
      localparam OP_IMM = 7'b0010011;
    
    always_comb begin
    imm = 32'b0;
    
     case (instr[6:0])    
     
        OP_IMM: begin
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
        
        OP_LUI, OP_AUIPC: begin
        imm = {instr[31:12], 12'b0};
        end
     endcase
           
end    
endmodule
