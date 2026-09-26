16-bit 5-Stage Pipelined RISC Processor

A custom 16-bit RISC Processor designed and implemented in Verilog HDL featuring a classic 5-stage instruction pipeline. The processor supports arithmetic, logical, memory, and branch operations while incorporating hazard detection and forwarding mechanisms to improve pipeline efficiency.

Overview

This project implements a pipelined RISC architecture consisting of the following stages:

Instruction Fetch (IF)
Instruction Decode (ID)
Execute (EX)
Memory Access (MEM)
Write Back (WB)

The design follows a modular RTL approach, making it suitable for simulation, verification, and FPGA implementation.

Features
16-bit custom RISC architecture
5-stage pipelined datapath
Arithmetic and logical operations through ALU
General-purpose register file
Separate instruction and data memory modules
Centralized control unit for instruction decoding
Data hazard handling using:
Operand forwarding
Pipeline stalling
Hazard detection logic
Control hazard mitigation using branch flush mechanisms
Modular and reusable RTL design
Compatible with Xilinx FPGA development tools
Architecture
                +----------------+
                | Instruction Mem|
                +-------+--------+
                        |
                        v
+------+    +------+    +------+    +------+    +------+
|  IF  | -> |  ID  | -> |  EX  | -> | MEM  | -> |  WB  |
+------+    +------+    +------+    +------+    +------+
                |            ^
                |            |
        +-------+----+  +----+--------+
        | Register   |  | Forwarding  |
        | File       |  | Unit        |
        +------------+  +-------------+
                |
        +-------+--------+
        | Hazard Detect  |
        | Unit           |
        +----------------+
Implemented Modules
Datapath Components
Program Counter (PC)
Instruction Memory
Register File
Arithmetic Logic Unit (ALU)
Data Memory
Pipeline Registers
Control Components
Main Control Unit
ALU Control Unit
Hazard Detection Unit
Forwarding Unit
Branch Control Logic
Hazard Handling
Data Hazards

Resolved using:

EX-to-EX forwarding
MEM-to-EX forwarding
Pipeline stalling when forwarding is insufficient
Control Hazards

Resolved using:

Branch detection
Pipeline flushing of incorrect instructions
Verification

Simulation-based verification was performed using comprehensive testbenches covering:

Arithmetic operations
Logical operations
Load/Store instructions
Branch instructions
Data hazard scenarios
Pipeline stalls
Forwarding paths
Branch flush behavior
Tools Used
Verilog HDL
Xilinx Vivado / ISE
ModelSim / Vivado Simulator
Project Structure
├── rtl/
│   ├── alu.v
│   ├── register_file.v
│   ├── control_unit.v
│   ├── forwarding_unit.v
│   ├── hazard_detection.v
│   ├── instruction_memory.v
│   ├── data_memory.v
│   └── processor_top.v
│
├── testbench/
│   ├── processor_tb.v
│   └── memory_tb.v
│
├── simulation/
│   ├── waveforms
│   └── outputs
│
└── README.md
Future Enhancements
Interrupt and exception handling
Cache memory integration
Branch prediction techniques
Extended instruction set support
FPGA hardware validation and performance analysis
Learning Outcomes

This project provided practical experience in:

Computer architecture and pipelining
RTL design using Verilog HDL
Hazard detection and resolution techniques
Digital system verification
FPGA-oriented hardware development
