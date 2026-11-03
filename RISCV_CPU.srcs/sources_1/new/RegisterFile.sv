module RegisterFile #(

parameter DW = 32, // sets each register’s data width to 32 bits.
parameter NB_REGS = 32

)(
    input  logic                          clk,
    input  logic                          rst,

    input  logic [$clog2(NB_REGS)-1:0]   ra1,
    output logic [DW-1:0]                 rd1,

    input  logic [$clog2(NB_REGS)-1:0]   ra2,
    output logic [DW-1:0]                 rd2,

    input  logic                          we,
    input  logic [$clog2(NB_REGS)-1:0]   wa,
    input  logic [DW-1:0]                  wd

);

reg [DW-1:0] regs [0:NB_REGS-1];
    integer i;

    always @(posedge clk) begin
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