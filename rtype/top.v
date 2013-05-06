`timescale 1ns / 1ps

module rtype(
	input clock,
	input [31:0] instruction,
	output [31:0] a_data,
	output [31:0] b_data,
	output [31:0] result
);

wire [4:0] rs, rt, rd;
assign rs = instruction[25:21];
assign rt = instruction[20:16];
assign rd = instruction[15:11];
reg_file r0(clock, rs, rt, rd, result, a_data, b_data, 1'b1);

wire [2:0] alu_op;
wire [3:0] func;
assign func = instruction[3:0];
aluc a0(2'b10, func, alu_op);
alu a1(a_data, b_data, alu_op, result);

endmodule

