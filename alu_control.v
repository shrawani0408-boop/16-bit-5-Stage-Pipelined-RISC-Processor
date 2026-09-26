`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:13:03 09/22/2026 
// Design Name: 
// Module Name:    alu_control 
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
module alu_control(
    input  [2:0] ALUOp,
    output reg [2:0] ALU_Control
);

    always @(*) begin

        case (ALUOp)

            3'b000: ALU_Control = 3'b000; // ADD
            3'b001: ALU_Control = 3'b001; // SUB
            3'b010: ALU_Control = 3'b010; // AND
            3'b011: ALU_Control = 3'b011; // OR
            3'b100: ALU_Control = 3'b100; // XOR

            default: ALU_Control = 3'b000;

        endcase

    end

endmodule
