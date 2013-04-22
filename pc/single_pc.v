`timescale 1ns / 1ps

module single_pc(
	input  clock,
	input  reset,
	input  [8:0] i_pc,
	output reg [8:0] o_pc
);

	always @(posedge clock) begin
		if (reset)
			o_pc = 0;
		else
			o_pc = i_pc;
	end

endmodule
