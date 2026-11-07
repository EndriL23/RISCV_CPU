`timescale 1ns / 1ps


module ControlUnit (

input logic [6:0] opcode,
input logic [2:0] funct3,
input logic [6:0] funct7,
output logic we,
output logic alu_src,
output logic [3:0] alu_control

);

localparam OP_R = 7'b0110011;
localparam OP_IMM = 7'b0010011;
    
    always_comb begin
    we = 1'b0;
    alu_src = 1'b0;
    alu_control = 1'b0;
    
       
       case (opcode)
       
       OP_R : begin
       we = 1'b1;
       alu_src = 1'b0;
       alu_control = 4'b0000; 
       end
       
       OP_IMM : begin
       we = 1'b1;
       alu_src = 1'b1;
       alu_control = 4'b0000; 
       end
            
       endcase

end
endmodule
