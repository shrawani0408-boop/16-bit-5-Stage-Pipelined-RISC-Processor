# 16-bit 5-Stage Pipelined RISC Processor

A custom **16-bit RISC Processor** designed and implemented in **Verilog HDL** featuring a classic **5-stage pipeline architecture**. The processor supports arithmetic, logical, memory, and branch instructions while incorporating hazard detection and forwarding mechanisms to improve execution efficiency.

---

## 📌 Project Overview

This project implements a pipelined RISC architecture consisting of the following stages:

1. **Instruction Fetch (IF)**
2. **Instruction Decode (ID)**
3. **Execute (EX)**
4. **Memory Access (MEM)**
5. **Write Back (WB)**

The design follows a modular RTL approach and is compatible with FPGA development workflows using Xilinx toolchains.

---

## ✨ Features

- 16-bit custom RISC instruction set architecture
- Five-stage instruction pipeline (IF, ID, EX, MEM, WB)
- Modular Verilog HDL implementation
- Arithmetic and Logical Unit (ALU)
- General-purpose Register File
- Instruction and Data Memory modules
- Control Unit for instruction decoding
- Hazard Detection Unit
- Operand Forwarding Unit
- Pipeline stalling for load-use hazards
- Branch flush mechanism for control hazards
- Simulation-based verification using testbenches
- FPGA-ready RTL design

---

## 🏗️ Processor Architecture

```text
                +----------------------+
                |  Instruction Memory  |
                +----------+-----------+
                           |
                           v

+-------+    +-------+    +-------+    +-------+    +-------+
|  IF   | -> |  ID   | -> |  EX   | -> | MEM   | -> |  WB   |
+-------+    +-------+    +-------+    +-------+    +-------+
                 |             ^
                 |             |
                 v             |
         +---------------+     |
         | Register File |-----+
         +---------------+

                 |
                 v
       +-------------------+
       | Hazard Detection  |
       +-------------------+

                 |
                 v
       +-------------------+
       | Forwarding Unit   |
       +-------------------+
```

---

## 📂 Project Structure

```text
16bit-pipelined-risc/
│
├── rtl/
│   ├── processor_top.v
│   ├── alu.v
│   ├── register_file.v
│   ├── instruction_memory.v
│   ├── data_memory.v
│   ├── control_unit.v
│   ├── forwarding_unit.v
│   ├── hazard_detection.v
│   └── pipeline_registers.v
│
├── testbench/
│   └── processor_tb.v
│
├── simulation/
│   ├── waveforms/
│   └── results/
│
├── docs/
│   └── architecture.pdf
│
├── LICENSE
└── README.md
```

---

## 🔧 Implemented Modules

### Datapath Components

- Program Counter (PC)
- Instruction Memory
- Register File
- ALU
- Data Memory
- Pipeline Registers

### Control Components

- Main Control Unit
- ALU Control Unit
- Hazard Detection Unit
- Forwarding Unit
- Branch Control Logic

---

## ⚠️ Hazard Handling

### Data Hazards

Implemented using:

- EX-to-EX Forwarding
- MEM-to-EX Forwarding
- Pipeline Stall Logic
- Load-Use Hazard Detection

### Control Hazards

Implemented using:

- Branch Decision Logic
- Pipeline Flush Mechanism

---

## 🧪 Verification

The processor was verified through simulation testbenches covering:

- Arithmetic Instructions
- Logical Instructions
- Register Operations
- Load and Store Instructions
- Branch Instructions
- Data Hazard Scenarios
- Forwarding Paths
- Pipeline Stalls
- Branch Flush Operations

---

## 🚀 Getting Started

### Prerequisites

- Xilinx Vivado / ISE
- ModelSim (optional)
- Verilog HDL Simulator

### Run Simulation

1. Clone the repository:

```bash
git clone https://github.com/your-username/16bit-pipelined-risc.git
cd 16bit-pipelined-risc
```

2. Open the project in Vivado or ModelSim.

3. Compile all RTL modules and the testbench.

4. Run simulation:

```bash
run -all
```

5. Observe waveform outputs and verify pipeline behavior.

---

## 📈 Future Enhancements

- Interrupt Handling
- Exception Support
- Branch Prediction
- Cache Memory Integration
- Multi-cycle Operations
- FPGA Hardware Validation

---

## 🛠️ Tools & Technologies

- Verilog HDL
- Xilinx Vivado
- ModelSim
- Digital Design
- Computer Architecture
- FPGA Design Flow

---

## 👩‍💻 Author

**Shrawani Wagh**

Electronics & Telecommunication Engineering  
Cummins College of Engineering for Women, Pune

---

## 📄 License

This project is licensed under the MIT License. See the `LICENSE` file for details.
