`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:16:07 09/22/2026 
// Design Name: 
// Module Name:    control_unit 
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
module control_unit(
    input  [3:0] opcode,

    output reg       RegWrite,
    output reg       ALUSrc,
    output reg       MemRead,
    output reg       MemWrite,
    output reg       MemToReg,
    output reg       Branch,
    output reg [2:0] ALUOp
);

    always @(*) begin

        // Default values
        RegWrite = 1'b0;
        ALUSrc   = 1'b0;
        MemRead  = 1'b0;
        MemWrite = 1'b0;
        MemToReg = 1'b0;
        Branch   = 1'b0;
        ALUOp    = 3'b000;

        case (opcode)

            // ADD
            4'b0000: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b0;
                ALUOp    = 3'b000;
            end

            // SUB
            4'b0001: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b0;
                ALUOp    = 3'b001;
            end

            // AND
            4'b0010: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b0;
                ALUOp    = 3'b010;
            end

            // OR
            4'b0011: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b0;
                ALUOp    = 3'b011;
            end

            // XOR
            4'b0100: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b0;
                ALUOp    = 3'b100;
            end

            // ADDI
            4'b0101: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                ALUOp    = 3'b000;
            end

            // LW
            4'b0110: begin
                RegWrite = 1'b1;
                ALUSrc   = 1'b1;
                MemRead  = 1'b1;
                MemToReg = 1'b1;
                ALUOp    = 3'b000;
            end

            // SW
            4'b0111: begin
                RegWrite = 1'b0;
                ALUSrc   = 1'b1;
                MemWrite = 1'b1;
                ALUOp    = 3'b000;
            end

            // BEQ
            4'b1000: begin
                RegWrite = 1'b0;
                ALUSrc   = 1'b0;
                Branch   = 1'b1;
                ALUOp    = 3'b001;
            end

            // NOP
            4'b1111: begin
                RegWrite = 1'b0;
                ALUSrc   = 1'b0;
                MemRead  = 1'b0;
                MemWrite = 1'b0;
                MemToReg = 1'b0;
                Branch   = 1'b0;
                ALUOp    = 3'b000;
            end

            default: begin
                // Keep default control signals
            end

        endcase

    end

endmodule