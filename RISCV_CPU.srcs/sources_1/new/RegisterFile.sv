module RegisterFile #(

parameter DW = 32, // sets each register’s data width to 32 bits.
parameter NB_REGS = 32

)(
    input  logic                          clk,
    input  logic                          rst,  //synchronous reset

    input  logic [$clog2(NB_REGS)-1:0]    ra1,   //First register address
    output logic [DW-1:0]                 rd1,  //The CPU can read two registers simultaneously (rd1 and rd2)

    input  logic [$clog2(NB_REGS)-1:0]    ra2,   //second register address
    output logic [DW-1:0]                 rd2,  

    input  logic                          we,  //Write enable
    input  logic [$clog2(NB_REGS)-1:0]    wa,  //Write destination address
    input  logic [DW-1:0]                 wd   //The CPU can write to one register per clock cycle

);

reg [DW-1:0] regs [0:NB_REGS-1];
    integer i;

    always_ff @(posedge clk) begin
        if (rst) begin
            for (i = 0; i < NB_REGS; i = i + 1)
                regs[i] <= {DW{1'b0}};
        end else if (we && wa != 0) begin
    regs[wa] <= wd;
    end
end
    // Combinational (single-cycle) reads: a CPU's decode stage can read
    // an operand the very same cycle it presents the register address.
    assign rd1 = regs[ra1];
    assign rd2 = regs[ra2];


endmodule