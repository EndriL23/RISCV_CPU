`timescale 1ns / 1ps


module ControlUnit (

input logic [6:0] opcode,    //The decoder reads this first.It tells it how to slice the other 25 bits
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
         
         3'b001: begin
         ////
         ////
         end
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
