`timescale 1ns / 1ps


module ControlUnit (

input logic [6:0] opcode,    //The decoder reads this first. It tells it how to slice the other 25 bits
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
    alu_control = 4'b0000;
    
       
       case (opcode)
       
       OP_R : begin
       we = 1'b1;
       alu_src = 1'b0;
         
         case (funct3) 
         
         3'b000: begin
            if (funct7 == 7'b0000000) begin
              alu_control = 4'b0000;
            end
            else if (funct7 == 7'b0100000) begin
              alu_control = 4'b0001;
            end
            else begin alu_control = 4'bx; end
         end
         
        
         3'b000: alu_control = funct7[5] ? 4'b0001 : 4'b0000;  // SUB : ADD
         3'b001: alu_control = 4'b0111;                        // SLL
         3'b010: alu_control = 4'b0101;                        // SLT
         3'b011: alu_control = 4'b0110;                        // SLTU
         3'b100: alu_control = 4'b0100;                        // XOR
         3'b101: alu_control = funct7[5] ? 4'b1001 : 4'b1000;  // SRA : SRL
         3'b110: alu_control = 4'b0011;                        // OR
         3'b111: alu_control = 4'b0010;                        // AND
         
         endcase
       end  
       
        
       OP_IMM : begin
       we = 1'b1;
       alu_src = 1'b1;
       alu_control = 4'b0000; 
       end
            
       endcase

end
endmodule
