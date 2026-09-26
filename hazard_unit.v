`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:56:44 09/23/2026 
// Design Name: 
// Module Name:    hazard_unit 
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
module hazard_unit(
    input        id_ex_memread,
    input  [2:0] id_ex_rd,

    input  [2:0] if_id_rs1,
    input  [2:0] if_id_rs2,

    output reg   pc_write,
    output reg   if_id_write,
    output reg   control_stall
);

    always @(*) begin

        // Normal operation
        pc_write      = 1'b1;
        if_id_write   = 1'b1;
        control_stall = 1'b0;

        // Load-use hazard
        if (id_ex_memread &&
            (id_ex_rd != 3'b000) &&
            ((id_ex_rd == if_id_rs1) ||
             (id_ex_rd == if_id_rs2))) begin

            pc_write      = 1'b0;
            if_id_write   = 1'b0;
            control_stall = 1'b1;

        end

    end

endmodule 