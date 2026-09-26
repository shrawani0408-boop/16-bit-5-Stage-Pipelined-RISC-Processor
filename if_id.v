`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:50:03 09/23/2026 
// Design Name: 
// Module Name:    if_id 
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
module if_id(
    input        clk,
    input        reset,
    input        write_enable,
    input        flush,

    input  [15:0] pc_in,
    input  [15:0] instruction_in,

    output reg [15:0] pc_out,
    output reg [15:0] instruction_out
);

    always @(posedge clk or posedge reset) begin

        if (reset) begin
            pc_out          <= 16'b0;
            instruction_out <= 16'b0;
        end

        else if (flush) begin
            pc_out          <= 16'b0;
            instruction_out <= 16'b0;
        end

        else if (write_enable) begin
            pc_out          <= pc_in;
            instruction_out <= instruction_in;
        end

    end

endmodule 