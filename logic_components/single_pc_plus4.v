`timescale 1ns / 1ps

module single_pc_plus4(
	input  [8:0] i_pc,
	output [8:0] o_pc
);

	assign o_pc = i_pc + 4;

endmodule
