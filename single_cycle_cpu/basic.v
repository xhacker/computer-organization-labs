module add(a, b, result);
	input [31:0] a;
	input [31:0] b;
	output [31:0] result;

	assign result = a + b;
endmodule


module and(a, b, result);
	input a;
	input b;
	output result;

	assign result = a & b;
endmodule


module mux(a, b, control, out);
	parameter N;
	input  wire [N-1:0] a, b;
	input  wire control;
	output wire [N-1:0] out;

	assign out = control ? b : a;
endmodule


module sign_extender(
	input  [15:0] input_16,
	output [31:0] output_32
);

assign output_32 = { {16{input_16[15]}}, input_16[15:0] };

endmodule