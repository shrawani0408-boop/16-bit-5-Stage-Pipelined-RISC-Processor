`timescale 1ns / 1ps

module instruction_memory(
    input  [15:0] address,
    output [15:0] instruction
);

    reg [15:0] memory [0:255];

    initial begin

        // ADDI R1, R0, 5
        memory[0] = 16'h5205;

        // NOP
        memory[1] = 16'hF000;
        memory[2] = 16'hF000;
        memory[3] = 16'hF000;
        memory[4] = 16'hF000;
        memory[5] = 16'hF000;

    end

    assign instruction = memory[address[7:0]];

endmodule 