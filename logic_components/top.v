`timescale 1ns / 1ps

module top(
	input  clock,
	input  reset,
	output [8:0] i_pc,
	output [8:0] o_pc
);

	single_pc M1(clock, reset, i_pc, o_pc);
	single_pc_plus4 M2(o_pc, i_pc);

endmodule
