`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/23/2026 02:54:06 PM
// Design Name: 
// Module Name: ALU
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// s
//////////////////////////////////////////////////////////////////////////////////


module ALU(
    input logic [31:0] a,
    input logic [31:0] b,
    input logic [3:0] alu_control,
    output logic [31:0] result,
    output logic zero,
    output logic overflow,
    output logic negative
    );
    
    always_comb begin
    result = 32'b0;
    overflow = 1'b0;
    
    case (alu_control)
       4'b0000: begin //ADD
       result = a + b;
       overflow = ~(a[31] ^ b[31]) & (result[31] ^ a[31]);
       end
       
       4'b0001: begin     //SUB
       result = a - b;    // a - b = a + b' + 1
       overflow = (a[31] ^ b[31]) & (result[31] ^ a[31]);
       end
       
       4'b0010: begin  //AND
       result = a & b;
       overflow = 1'b0;  //doesn't produce a carry out so its always 0
       end
       
       4'b0011: begin  //OR
       result = a | b;
       overflow = 1'b0;
       end
       
       4'b0100: begin  //XOR
       result = a ^ b;
       overflow = 1'b0;
       end
       
       4'b0101: begin //SLT (Set less than)
       result = ($signed(a) < $signed(b)) ? 32'b1 : 32'b0;
       overflow = 1'b0;
       end
       
       4'b0110: begin //SLTU (Set less than unsigned)
       result = (a < b) ? 32'b1 : 32'b0;
       overflow = 1'b0;
       end
       
       4'b0111: begin //SLL (Shift left logical)
       result = (a << b[4:0]);
       overflow = 1'b0;
       end
       
       
       4'b1000: begin //SRL (Shift right logical)
       result = (a >> b[4:0]);
       overflow = 1'b0;
       end
       
       4'b1001: begin //SRA (Shift right arithmetic)
       result = (a >>> b[4:0]);
       overflow = 1'b0;
       end
       
       endcase
       
     zero = (result == 32'b0);
     negative = result[31];
     
     end
endmodule


