`timescale 1ns / 1ps

module sign_extender(
	input  [15:0] input_16,
	output [31:0] output_32
);

assign output_32 = { {16{input_16[15]}}, input_16[15:0] };

endmodule
