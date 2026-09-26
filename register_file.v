`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:37:25 09/22/2026 
// Design Name: 
// Module Name:    register_file 
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
module register_file(
    input        clk,
    input        reset,

    input  [2:0] rs1,
    input  [2:0] rs2,

    input  [2:0] rd,
    input [15:0] write_data,
    input        reg_write,

    output [15:0] read_data1,
    output [15:0] read_data2
);

    reg [15:0] registers [0:7];

    integer i;

    // Read ports
    assign read_data1 = (rs1 == 3'b000) ? 16'b0 : registers[rs1];
    assign read_data2 = (rs2 == 3'b000) ? 16'b0 : registers[rs2];

    // Write port
    always @(posedge clk or posedge reset) begin

        if (reset) begin

            for (i = 0; i < 8; i = i + 1) begin
                registers[i] <= 16'b0;
            end

        end
        else if (reg_write && (rd != 3'b000)) begin

            registers[rd] <= write_data;

        end

    end

endmodule 