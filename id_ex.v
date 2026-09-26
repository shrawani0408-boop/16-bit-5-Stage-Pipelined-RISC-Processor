`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:52:25 09/23/2026 
// Design Name: 
// Module Name:    id_ex 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module id_ex(
    input        clk,
    input        reset,
    input        flush,

    // Data
    input  [15:0] pc_in,
    input  [15:0] read_data1_in,
    input  [15:0] read_data2_in,
    input  [15:0] immediate_in,

    // Register addresses
    input  [2:0] rs1_in,
    input  [2:0] rs2_in,
    input  [2:0] rd_in,

    // Control signals
    input        RegWrite_in,
    input        ALUSrc_in,
    input        MemRead_in,
    input        MemWrite_in,
    input        MemToReg_in,
    input        Branch_in,
    input  [2:0] ALUOp_in,

    // Outputs
    output reg [15:0] pc_out,
    output reg [15:0] read_data1_out,
    output reg [15:0] read_data2_out,
    output reg [15:0] immediate_out,

    output reg [2:0] rs1_out,
    output reg [2:0] rs2_out,
    output reg [2:0] rd_out,

    output reg       RegWrite_out,
    output reg       ALUSrc_out,
    output reg       MemRead_out,
    output reg       MemWrite_out,
    output reg       MemToReg_out,
    output reg       Branch_out,
    output reg [2:0] ALUOp_out
);

    always @(posedge clk or posedge reset) begin

        if (reset) begin

            pc_out          <= 16'b0;
            read_data1_out  <= 16'b0;
            read_data2_out  <= 16'b0;
            immediate_out   <= 16'b0;

            rs1_out         <= 3'b0;
            rs2_out         <= 3'b0;
            rd_out          <= 3'b0;

            RegWrite_out    <= 1'b0;
            ALUSrc_out      <= 1'b0;
            MemRead_out     <= 1'b0;
            MemWrite_out    <= 1'b0;
            MemToReg_out    <= 1'b0;
            Branch_out      <= 1'b0;
            ALUOp_out       <= 3'b000;

        end

        else if (flush) begin

            RegWrite_out    <= 1'b0;
            ALUSrc_out      <= 1'b0;
            MemRead_out     <= 1'b0;
            MemWrite_out    <= 1'b0;
            MemToReg_out    <= 1'b0;
            Branch_out      <= 1'b0;
            ALUOp_out       <= 3'b000;

        end

        else begin

            pc_out          <= pc_in;
            read_data1_out  <= read_data1_in;
            read_data2_out  <= read_data2_in;
            immediate_out   <= immediate_in;

            rs1_out         <= rs1_in;
            rs2_out         <= rs2_in;
            rd_out          <= rd_in;

            RegWrite_out    <= RegWrite_in;
            ALUSrc_out      <= ALUSrc_in;
            MemRead_out     <= MemRead_in;
            MemWrite_out    <= MemWrite_in;
            MemToReg_out    <= MemToReg_in;
            Branch_out      <= Branch_in;
            ALUOp_out       <= ALUOp_in;

        end

    end

endmodule
