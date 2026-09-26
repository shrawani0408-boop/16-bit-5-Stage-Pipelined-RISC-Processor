`timescale 1ns / 1ps
module data_memory(
    input        clk,
    input        reset,

    input        mem_read,
    input        mem_write,

    input  [15:0] address,
    input  [15:0] write_data,

    output [15:0] read_data
);

    reg [15:0] memory [0:255];

    integer i;

    // Read from memory
    assign read_data = mem_read ? memory[address[7:0]] : 16'b0;

    // Write to memory
    always @(posedge clk or posedge reset) begin

        if (reset) begin
            for (i = 0; i < 256; i = i + 1)
                memory[i] <= 16'b0;
        end

        else if (mem_write) begin
            memory[address[7:0]] <= write_data;
        end

    end

endmodule