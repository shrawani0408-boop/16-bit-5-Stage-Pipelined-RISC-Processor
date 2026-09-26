`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:54:07 09/23/2026 
// Design Name: 
// Module Name:    mem_wb 
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
module mem_wb(
    input        clk,
    input        reset,

    // Data from MEM stage
    input  [15:0] alu_result_in,
    input  [15:0] memory_data_in,

    // Destination register
    input  [2:0] rd_in,

    // Control signals
    input        RegWrite_in,
    input        MemToReg_in,

    // Outputs to WB stage
    output reg [15:0] alu_result_out,
    output reg [15:0] memory_data_out,

    output reg [2:0] rd_out,

    output reg       RegWrite_out,
    output reg       MemToReg_out
);

    always @(posedge clk or posedge reset) begin

        if (reset) begin

            alu_result_out  <= 16'b0;
            memory_data_out <= 16'b0;

            rd_out          <= 3'b0;

            RegWrite_out    <= 1'b0;
            MemToReg_out    <= 1'b0;

        end

        else begin

            alu_result_out  <= alu_result_in;
            memory_data_out <= memory_data_in;

            rd_out          <= rd_in;

            RegWrite_out    <= RegWrite_in;
            MemToReg_out    <= MemToReg_in;

        end

    end

endmodule