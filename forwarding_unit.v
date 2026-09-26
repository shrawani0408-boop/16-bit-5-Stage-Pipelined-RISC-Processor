`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:55:15 09/23/2026 
// Design Name: 
// Module Name:    forwarding_unit 
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
module forwarding_unit(
    input  [2:0] rs1,
    input  [2:0] rs2,

    input  [2:0] ex_mem_rd,
    input        ex_mem_regwrite,

    input  [2:0] mem_wb_rd,
    input        mem_wb_regwrite,

    output reg [1:0] forward_a,
    output reg [1:0] forward_b
);

    always @(*) begin

        // Default: use values from register file
        forward_a = 2'b00;
        forward_b = 2'b00;

        // Forward from EX/MEM to ALU input A
        if (ex_mem_regwrite &&
            (ex_mem_rd != 3'b000) &&
            (ex_mem_rd == rs1)) begin

            forward_a = 2'b01;

        end

        // Forward from MEM/WB to ALU input A
        else if (mem_wb_regwrite &&
                 (mem_wb_rd != 3'b000) &&
                 (mem_wb_rd == rs1)) begin

            forward_a = 2'b10;

        end

        // Forward from EX/MEM to ALU input B
        if (ex_mem_regwrite &&
            (ex_mem_rd != 3'b000) &&
            (ex_mem_rd == rs2)) begin

            forward_b = 2'b01;

        end

        // Forward from MEM/WB to ALU input B
        else if (mem_wb_regwrite &&
                 (mem_wb_rd != 3'b000) &&
                 (mem_wb_rd == rs2)) begin

            forward_b = 2'b10;

        end

    end

endmodule 