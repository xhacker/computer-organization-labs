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


module single_pc_plus4(
	input  [8:0] i_pc,
	output [8:0] o_pc
);

	assign o_pc = i_pc + 4;

endmodule