`timescale 1ns / 1ps


module tb_ControlUnit;

logic [6:0] opcode;
logic [6:0] funct7;
logic [2:0] funct3;
logic we;
logic alu_src;
logic [3:0] alu_control;

  ControlUnit inst0 (
     
     .opcode(opcode),
     .funct7(funct7),
     .funct3(funct3),
     .we(we),
     .alu_src(alu_src),
     .alu_control(alu_control)
  
  );
  
  initial begin
  opcode = 7'b0;
  funct7 = 7'b0;
  funct3 = 3'b0;
  
  #10
  opcode = 7'b0110011;
  funct7 = 7'b0000000;
  funct3 = 3'b000;
  
  #10
  opcode = 7'b0010011;
  funct7 = 7'b1111111;
  funct3 = 3'b000;
  
  #10
  opcode = 7'b0000011;
  funct7 = 7'b1111111;
  funct3 = 3'b111;

end    
endmodule
