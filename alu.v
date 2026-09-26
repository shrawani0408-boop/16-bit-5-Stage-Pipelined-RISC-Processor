`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:27:13 09/22/2026 
// Design Name: 
// Module Name:    alu 
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
module alu(A, B, control, result, zero);
    input [15:0] A;
    input [15:0] B;
    input [2:0] control;
    output reg [15:0] result;
    output zero;
	 
	 always @(*)
		begin
			case (control)
				3'b000:result=A+B;
				3'b001:result=A-B;
				3'b010:result=A&B;
				3'b011:result=A|B;
				3'b100:result=A^B;
				default:result=16'b0;
			endcase
		end
		
		assign zero = (result == 16'b0);

endmodule
