`timescale 1ns / 1ps


module ControlUnit (

input logic [6:0] opcode,    //The decoder reads this first. It tells it how to slice the other 25 bits
input logic [2:0] funct3,
input logic [6:0] funct7,
output logic we,
output logic alu_src,
output logic [3:0] alu_control,
output logic [1:0] alu_src_a

);

localparam OP_R = 7'b0110011;
localparam OP_IMM = 7'b0010011;
localparam OP_LUI   = 7'b0110111;
localparam OP_AUIPC = 7'b0010111;
    
    always_comb begin
    we = 1'b0;
    alu_src = 1'b0;
    alu_src_a = 2'b00;
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
         
          3'b001: alu_control = 4'b0111;                        // SLL
          3'b010: alu_control = 4'b0101;                        // SLT
          3'b011: alu_control = 4'b0110;                        // SLTU
          3'b100: alu_control = 4'b0100;                        // XOR
          3'b101: begin
             if (funct7 == 7'b0000000) begin
               alu_control = 4'b1000;                           //SRL
             end
             else if (funct7 == 7'b0100000) begin
               alu_control = 4'b1001;                           //SRA
             end
             else begin alu_control = 4'bx; end
          end
          3'b110: alu_control = 4'b0011;                        // OR
          3'b111: alu_control = 4'b0010;                        // AND
         
         endcase
       end  
       
        
       OP_IMM : begin
       we = 1'b1;
       alu_src = 1'b1;
       
         case (funct3)
    
           3'b000: alu_control = 4'b0000;                        // ADDI (never SUB)
           3'b001: alu_control = 4'b0111;                        // SLLI
           3'b010: alu_control = 4'b0101;                        // SLTI
           3'b011: alu_control = 4'b0110;                        // SLTIU
           3'b100: alu_control = 4'b0100;                        // XORI
           3'b101: begin
              if (funct7 == 7'b0000000) begin
                alu_control = 4'b1000;                           // SRLI
              end
              else if (funct7 == 7'b0100000) begin
                alu_control = 4'b1001;                           // SRAI
              end
              else begin alu_control = 4'bx; end
           end 
           3'b110: alu_control = 4'b0011;                        // ORI
           3'b111: alu_control = 4'b0010;                        // ANDI
   
         endcase
       
       end
       
             
       OP_LUI : begin                  // x[rd] = 0 + imm
           we          = 1'b1;
           alu_src     = 1'b1;           // b = U-immediate
           alu_src_a   = 2'b10;          // a = 0
           alu_control = 4'b0000;        // ADD
      end

      OP_AUIPC : begin                // x[rd] = PC + imm
           we          = 1'b1;
           alu_src     = 1'b1;           // b = U-immediate
           alu_src_a   = 2'b01;          // a = PC
           alu_control = 4'b0000;        // ADD
      end
      
      default: ;  //ignore unknown opcodes
               
    endcase

end
endmodule
