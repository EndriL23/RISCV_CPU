`timescale 1ns / 1ps

module tb_CPU_Top;
logic clk;
logic rst;


   CPU_Top inst0 (
   
   .clk(clk),
   .rst(rst)
  
   );


initial begin
clk = 0;
forever #5 clk = ~clk;
end

initial begin
rst = 1;
#30 rst = ~rst;
end


endmodule
