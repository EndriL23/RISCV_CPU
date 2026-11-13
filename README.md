# RISCV_CPU

A single-cycle RISC-V (RV32I) soft-core CPU written in SystemVerilog, targeting the
Digilent Nexys A7-100T (Xilinx Artix-7 XC7A100T).

## Status

Work in progress. The core datapath is complete and runs a test program in simulation.

**Supported instructions so far**

- **R-type:** `add`, `sub`, `sll`, `slt`, `sltu`, `xor`, `srl`, `sra`, `or`, `and`
- **I-type arithmetic:** `addi`, `slti`, `sltiu`, `xori`, `ori`, `andi`, `slli`, `srli`, `srai`
- **U-type:** `lui`, `auipc`

**Not yet implemented:** loads and stores, branches, jumps (`jal`, `jalr`).

## Modules

| Module | File | Description | Testbench |
|---|---|---|---|
| ALU | `ALU.sv` | ADD, SUB, AND, OR, XOR, SLT, SLTU, SLL, SRL, SRA, plus zero / overflow / negative flags | `tb_ALU.sv` |
| Register file | `RegisterFile.sv` | 32 registers x 32 bits, two combinational read ports, one synchronous write port, writes to x0 ignored | covered by `tb_CPU_Top.sv` |
| Program counter | `ProgramCounter.sv` | 32-bit register with synchronous reset | `tb_ProgramCounter.sv` |
| Instruction memory | `InstructionMemory.sv` | 256 words, loaded from `program.mem` with `$readmemh`, combinational read | `tb_InstructionMemory.sv` |
| Immediate generator | `ImmediateGenerator.sv` | Sign-extended I-type immediate and U-type upper immediate | `tb_ImmediateGenerator.sv` |
| Control unit | `ControlUnit.sv` | Decodes opcode, `funct3` and `funct7` into `we`, `alu_src`, `alu_src_a` and `alu_control` | `tb_ControlUnit.sv` |
| CPU top | `CPU_Top.sv` | Wires every block into one single-cycle datapath, including the `pc + 4` adder and the operand muxes | `tb_CPU_Top.sv` |

## Design notes

- **Single-cycle:** fetch, decode, execute and write-back all happen within one clock cycle, so one instruction completes per clock edge.
- **Addressing:** the PC counts in bytes (0, 4, 8, ...), while the instruction memory is an array of 32-bit words, so the bottom two address bits are dropped when indexing.
- **Operand muxes:** `alu_src` chooses between the second register and the immediate for ALU input B. `alu_src_a` chooses between a register, zero (`lui`) and the PC (`auipc`) for ALU input A.
- **Defaults:** the control unit assigns safe defaults before decoding, so an unknown opcode never writes a register and no latches are inferred.

## Roadmap

- [x] ALU
- [x] Register file
- [x] Program counter and instruction memory
- [x] Immediate generator (I-type and U-type)
- [x] Control unit (R-type, I-type arithmetic, `lui`, `auipc`)
- [x] Single-cycle top-level integration (arithmetic instructions)
- [ ] Data memory and load / store instructions (S-type immediate)
- [ ] Branch logic
- [ ] Jumps (`jal`, `jalr`)
- [ ] C++ instruction-level reference model for verification
- [ ] Run a test program on the Nexys A7

## Tools

- Vivado 2025.1
- SystemVerilog, Vivado Simulator

## Project layout

- `RISCV_CPU.srcs/sources_1/new/`: design sources
- `RISCV_CPU.srcs/sim_1/new/`: testbenches
- `program.mem`: test program loaded into the instruction memory
- `RISCV_CPU.xpr`: Vivado project file

## Simulating

1. Open `RISCV_CPU.xpr` in Vivado 2025.1.
2. Set `tb_CPU_Top` as the simulation top module.
3. Run Simulation > Run Behavioral Simulation, then `run 150 ns` in the Tcl console.
4. In the Scope panel, select the `CPU_Top` instance and add its signals to the waveform. Select `regfile` to see the register contents.

Each block also has its own testbench. Set it as the simulation top module the same way.

## Test program

`program.mem` holds a nine-instruction program covering each instruction class:

| # | Instruction | Result |
|---|---|---|
| 1 | `addi x1, x0, 5` | x1 = `0x00000005` |
| 2 | `addi x2, x0, 10` | x2 = `0x0000000a` |
| 3 | `add x3, x1, x2` | x3 = `0x0000000f` |
| 4 | `sub x4, x2, x1` | x4 = `0x00000005` |
| 5 | `lui x5, 0x12345` | x5 = `0x12345000` |
| 6 | `auipc x6, 1` | x6 = `0x00001014` |
| 7 | `slli x7, x2, 2` | x7 = `0x00000028` |
| 8 | `addi x8, x0, -16` | x8 = `0xfffffff0` |
| 9 | `srai x9, x8, 2` | x9 = `0xfffffffc` |
