`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:53:17 09/23/2026 
// Design Name: 
// Module Name:    ex_mem 
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
module ex_mem(
    input        clk,
    input        reset,

    // Data from EX stage
    input  [15:0] alu_result_in,
    input  [15:0] write_data_in,

    // Destination register
    input  [2:0] rd_in,

    // Control signals
    input        RegWrite_in,
    input        MemRead_in,
    input        MemWrite_in,
    input        MemToReg_in,

    // Outputs to MEM stage
    output reg [15:0] alu_result_out,
    output reg [15:0] write_data_out,

    output reg [2:0] rd_out,

    output reg       RegWrite_out,
    output reg       MemRead_out,
    output reg       MemWrite_out,
    output reg       MemToReg_out
);

    always @(posedge clk or posedge reset) begin

        if (reset) begin

            alu_result_out <= 16'b0;
            write_data_out <= 16'b0;

            rd_out         <= 3'b0;

            RegWrite_out   <= 1'b0;
            MemRead_out    <= 1'b0;
            MemWrite_out   <= 1'b0;
            MemToReg_out   <= 1'b0;

        end

        else begin

            alu_result_out <= alu_result_in;
            write_data_out <= write_data_in;

            rd_out         <= rd_in;

            RegWrite_out   <= RegWrite_in;
            MemRead_out    <= MemRead_in;
            MemWrite_out   <= MemWrite_in;
            MemToReg_out   <= MemToReg_in;

        end

    end

endmodule