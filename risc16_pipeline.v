`timescale 1ns / 1ps

module risc16_pipeline(
    input clk,
    input reset
);

    // =========================================================
    // PROGRAM COUNTER
    // =========================================================

    reg [15:0] PC;

    wire [15:0] instruction;
    wire [15:0] pc_plus_one;
    wire [15:0] branch_target;
    wire        branch_taken;

    assign pc_plus_one = PC + 16'd1;


    // =========================================================
    // ALL PIPELINE SIGNAL DECLARATIONS
    // =========================================================

    // IF/ID
    wire [15:0] if_id_pc;
    wire [15:0] if_id_instruction;

    wire if_id_write;
    wire if_id_flush;


    // ID/EX
    wire [15:0] id_ex_pc;
    wire [15:0] id_ex_read_data1;
    wire [15:0] id_ex_read_data2;
    wire [15:0] id_ex_immediate;

    wire [2:0] id_ex_rs1;
    wire [2:0] id_ex_rs2;
    wire [2:0] id_ex_rd;

    wire id_ex_regwrite;
    wire id_ex_alusrc;
    wire id_ex_memread;
    wire id_ex_memwrite;
    wire id_ex_memtoreg;
    wire id_ex_branch;
    wire [2:0] id_ex_aluop;


    // EX/MEM
    wire [15:0] ex_mem_alu_result;
    wire [15:0] ex_mem_write_data;

    wire [2:0] ex_mem_rd;

    wire ex_mem_regwrite;
    wire ex_mem_memread;
    wire ex_mem_memwrite;
    wire ex_mem_memtoreg;


    // MEM/WB
    wire [15:0] mem_wb_alu_result;
    wire [15:0] mem_wb_memory_data;

    wire [2:0] mem_wb_rd;

    wire mem_wb_regwrite;
    wire mem_wb_memtoreg;


    // =========================================================
    // INSTRUCTION MEMORY
    // =========================================================

    instruction_memory IMEM(
        .address(PC),
        .instruction(instruction)
    );


    // =========================================================
    // IF/ID PIPELINE REGISTER
    // =========================================================

    if_id IF_ID(
        .clk(clk),
        .reset(reset),
        .write_enable(if_id_write),
        .flush(if_id_flush),

        .pc_in(PC),
        .instruction_in(instruction),

        .pc_out(if_id_pc),
        .instruction_out(if_id_instruction)
    );


    // =========================================================
    // INSTRUCTION DECODE
    // =========================================================

    wire [3:0] opcode;

    assign opcode = if_id_instruction[15:12];

    reg [2:0] rs1;
    reg [2:0] rs2;
    reg [2:0] rd;

    always @(*) begin

        rs1 = 3'b000;
        rs2 = 3'b000;
        rd  = 3'b000;

        case (opcode)

            // R-type
            4'b0000,
            4'b0001,
            4'b0010,
            4'b0011,
            4'b0100: begin

                rd  = if_id_instruction[11:9];
                rs1 = if_id_instruction[8:6];
                rs2 = if_id_instruction[5:3];

            end

            // ADDI / LW
            4'b0101,
            4'b0110: begin

                rd  = if_id_instruction[11:9];
                rs1 = if_id_instruction[8:6];

            end

            // SW
            4'b0111: begin

                rs2 = if_id_instruction[11:9];
                rs1 = if_id_instruction[8:6];

            end

            // BEQ
            4'b1000: begin

                rs1 = if_id_instruction[11:9];
                rs2 = if_id_instruction[8:6];

            end

            default: begin

                rs1 = 3'b000;
                rs2 = 3'b000;
                rd  = 3'b000;

            end

        endcase

    end


    // =========================================================
    // WRITE-BACK SIGNALS
    // =========================================================

    wire [15:0] wb_write_data;
    wire        wb_regwrite;


    // =========================================================
    // REGISTER FILE
    // =========================================================

    wire [15:0] read_data1;
    wire [15:0] read_data2;

    register_file REGFILE(
        .clk(clk),
        .reset(reset),

        .rs1(rs1),
        .rs2(rs2),

        .rd(mem_wb_rd),
        .write_data(wb_write_data),
        .reg_write(wb_regwrite),

        .read_data1(read_data1),
        .read_data2(read_data2)
    );


    // =========================================================
    // IMMEDIATE GENERATION
    // =========================================================

    wire [15:0] immediate;

    assign immediate = {{10{if_id_instruction[5]}},
                         if_id_instruction[5:0]};


    // =========================================================
    // CONTROL UNIT
    // =========================================================

    wire       RegWrite;
    wire       ALUSrc;
    wire       MemRead;
    wire       MemWrite;
    wire       MemToReg;
    wire       Branch;
    wire [2:0] ALUOp;

    control_unit CONTROL(
        .opcode(opcode),

        .RegWrite(RegWrite),
        .ALUSrc(ALUSrc),
        .MemRead(MemRead),
        .MemWrite(MemWrite),
        .MemToReg(MemToReg),
        .Branch(Branch),
        .ALUOp(ALUOp)
    );


    // =========================================================
    // HAZARD DETECTION
    // =========================================================

    wire pc_write;
    wire hazard_if_id_write;
    wire control_stall;

    hazard_unit HAZARD(
        .id_ex_memread(id_ex_memread),
        .id_ex_rd(id_ex_rd),

        .if_id_rs1(rs1),
        .if_id_rs2(rs2),

        .pc_write(pc_write),
        .if_id_write(hazard_if_id_write),
        .control_stall(control_stall)
    );

    assign if_id_write = hazard_if_id_write;


    // =========================================================
    // ID/EX CONTROL SIGNALS
    // =========================================================

    wire idex_RegWrite_in;
    wire idex_ALUSrc_in;
    wire idex_MemRead_in;
    wire idex_MemWrite_in;
    wire idex_MemToReg_in;
    wire idex_Branch_in;
    wire [2:0] idex_ALUOp_in;


    // Insert bubble during load-use hazard
    assign idex_RegWrite_in = control_stall ? 1'b0 : RegWrite;
    assign idex_ALUSrc_in   = control_stall ? 1'b0 : ALUSrc;
    assign idex_MemRead_in  = control_stall ? 1'b0 : MemRead;
    assign idex_MemWrite_in = control_stall ? 1'b0 : MemWrite;
    assign idex_MemToReg_in = control_stall ? 1'b0 : MemToReg;
    assign idex_Branch_in   = control_stall ? 1'b0 : Branch;
    assign idex_ALUOp_in    = control_stall ? 3'b000 : ALUOp;


    // =========================================================
    // ID/EX PIPELINE REGISTER
    // =========================================================

    wire id_ex_flush;

    assign id_ex_flush = branch_taken;

    id_ex ID_EX(
        .clk(clk),
        .reset(reset),
        .flush(id_ex_flush),

        .pc_in(if_id_pc),
        .read_data1_in(read_data1),
        .read_data2_in(read_data2),
        .immediate_in(immediate),

        .rs1_in(rs1),
        .rs2_in(rs2),
        .rd_in(rd),

        .RegWrite_in(idex_RegWrite_in),
        .ALUSrc_in(idex_ALUSrc_in),
        .MemRead_in(idex_MemRead_in),
        .MemWrite_in(idex_MemWrite_in),
        .MemToReg_in(idex_MemToReg_in),
        .Branch_in(idex_Branch_in),
        .ALUOp_in(idex_ALUOp_in),

        .pc_out(id_ex_pc),
        .read_data1_out(id_ex_read_data1),
        .read_data2_out(id_ex_read_data2),
        .immediate_out(id_ex_immediate),

        .rs1_out(id_ex_rs1),
        .rs2_out(id_ex_rs2),
        .rd_out(id_ex_rd),

        .RegWrite_out(id_ex_regwrite),
        .ALUSrc_out(id_ex_alusrc),
        .MemRead_out(id_ex_memread),
        .MemWrite_out(id_ex_memwrite),
        .MemToReg_out(id_ex_memtoreg),
        .Branch_out(id_ex_branch),
        .ALUOp_out(id_ex_aluop)
    );


    // =========================================================
    // FORWARDING UNIT
    // =========================================================

    wire [1:0] forward_a;
    wire [1:0] forward_b;

    forwarding_unit FORWARD(
        .rs1(id_ex_rs1),
        .rs2(id_ex_rs2),

        .ex_mem_rd(ex_mem_rd),
        .ex_mem_regwrite(ex_mem_regwrite),

        .mem_wb_rd(mem_wb_rd),
        .mem_wb_regwrite(mem_wb_regwrite),

        .forward_a(forward_a),
        .forward_b(forward_b)
    );


    // =========================================================
    // FORWARDING MUXES
    // =========================================================

    reg [15:0] alu_input_a;
    reg [15:0] forwarded_b;

    always @(*) begin

        case (forward_a)

            2'b00:
                alu_input_a = id_ex_read_data1;

            2'b01:
                alu_input_a = ex_mem_alu_result;

            2'b10:
                alu_input_a = wb_write_data;

            default:
                alu_input_a = id_ex_read_data1;

        endcase


        case (forward_b)

            2'b00:
                forwarded_b = id_ex_read_data2;

            2'b01:
                forwarded_b = ex_mem_alu_result;

            2'b10:
                forwarded_b = wb_write_data;

            default:
                forwarded_b = id_ex_read_data2;

        endcase

    end


    // =========================================================
    // ALU INPUT B
    // =========================================================

    wire [15:0] alu_input_b;

    assign alu_input_b = id_ex_alusrc ?
                         id_ex_immediate :
                         forwarded_b;


    // =========================================================
    // ALU CONTROL
    // =========================================================

    wire [2:0] alu_control_signal;

    alu_control ALU_CONTROL(
        .ALUOp(id_ex_aluop),
        .ALU_Control(alu_control_signal)
    );


    // =========================================================
    // ALU
    // =========================================================

    wire [15:0] alu_result;
    wire        alu_zero;

    alu ALU(
        .A(alu_input_a),
        .B(alu_input_b),
        .ALU_Control(alu_control_signal),

        .Result(alu_result),
        .Zero(alu_zero)
    );


    // =========================================================
    // BRANCH
    // =========================================================

    assign branch_taken = id_ex_branch && alu_zero;

    assign branch_target =
        id_ex_pc + 16'd1 + id_ex_immediate;


    // =========================================================
    // EX/MEM PIPELINE REGISTER
    // =========================================================

    ex_mem EX_MEM(
        .clk(clk),
        .reset(reset),

        .alu_result_in(alu_result),
        .write_data_in(forwarded_b),

        .rd_in(id_ex_rd),

        .RegWrite_in(id_ex_regwrite),
        .MemRead_in(id_ex_memread),
        .MemWrite_in(id_ex_memwrite),
        .MemToReg_in(id_ex_memtoreg),

        .alu_result_out(ex_mem_alu_result),
        .write_data_out(ex_mem_write_data),

        .rd_out(ex_mem_rd),

        .RegWrite_out(ex_mem_regwrite),
        .MemRead_out(ex_mem_memread),
        .MemWrite_out(ex_mem_memwrite),
        .MemToReg_out(ex_mem_memtoreg)
    );


    // =========================================================
    // DATA MEMORY
    // =========================================================

    wire [15:0] memory_data;

    data_memory DATA_MEM(
        .clk(clk),
        .reset(reset),

        .mem_read(ex_mem_memread),
        .mem_write(ex_mem_memwrite),

        .address(ex_mem_alu_result),
        .write_data(ex_mem_write_data),

        .read_data(memory_data)
    );


    // =========================================================
    // MEM/WB PIPELINE REGISTER
    // =========================================================

    mem_wb MEM_WB(
        .clk(clk),
        .reset(reset),

        .alu_result_in(ex_mem_alu_result),
        .memory_data_in(memory_data),

        .rd_in(ex_mem_rd),

        .RegWrite_in(ex_mem_regwrite),
        .MemToReg_in(ex_mem_memtoreg),

        .alu_result_out(mem_wb_alu_result),
        .memory_data_out(mem_wb_memory_data),

        .rd_out(mem_wb_rd),

        .RegWrite_out(mem_wb_regwrite),
        .MemToReg_out(mem_wb_memtoreg)
    );


    // =========================================================
    // WRITE-BACK
    // =========================================================

    assign wb_write_data =
        mem_wb_memtoreg ?
        mem_wb_memory_data :
        mem_wb_alu_result;

    assign wb_regwrite = mem_wb_regwrite;


    // =========================================================
    // IF/ID FLUSH
    // =========================================================

    assign if_id_flush = branch_taken;


    // =========================================================
    // PROGRAM COUNTER UPDATE
    // =========================================================

    always @(posedge clk or posedge reset) begin

        if (reset) begin

            PC <= 16'b0;

        end

        else if (pc_write) begin

            if (branch_taken)
                PC <= branch_target;

            else
                PC <= pc_plus_one;

        end

    end

endmodule 