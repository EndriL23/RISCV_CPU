# RISCV_CPU

A single-cycle RISC-V (RV32I) soft-core CPU written in SystemVerilog, targeting the
Digilent Nexys A7-100T (Xilinx Artix-7 XC7A100T).

## Status

Work in progress. Completed so far:

- **ALU**: ADD, SUB, AND, OR, XOR, SLT, SLTU, SLL, SRL, SRA
- **Register file**: 32 registers x 32 bits, two combinational read
  ports and one synchronous write port, with writes to x0 ignored
- **Testbench**: basic testbench (tb_ALU.sv) for the ALU

## Roadmap

- [ ] Program counter and instruction memory
- [ ] Immediate generator
- [ ] Data memory
- [ ] Branch logic
- [ ] Control unit / instruction decoder
- [ ] Single-cycle top-level integration
- [ ] C++ instruction-level reference model for verification
- [ ] Run a test program on the Nexys A7

## Tools

- Vivado 2025.1
- SystemVerilog, Vivado Simulator

## Project layout

- RISCV_CPU.srcs/sources_1/new/: design sources (ALU.sv, RegisterFile.sv)
- RISCV_CPU.srcs/sim_1/new/: testbenches
- RISCV_CPU.xpr: Vivado project file

## Simulating

1. Open RISCV_CPU.xpr in Vivado 2025.1.
2. Set tb_ALU as the simulation top module.
3. Run Simulation > Run Behavioral Simulation.
