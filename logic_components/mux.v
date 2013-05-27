`timescale 1ns / 1ps

module mux(a, b, control, out);

	parameter N = 4;
	input  wire [N-1:0] a, b;
	input  wire control;
	output wire [N-1:0] out;

	assign out = control ? b : a;

endmodule
