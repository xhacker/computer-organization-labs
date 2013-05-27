`timescale 1ns / 1ps

module sign_extender_test;

	reg [15:0] input_16;
	wire [31:0] output_32;

	sign_extender uut (
		.input_16(input_16), 
		.output_32(output_32)
	);

	initial begin
		input_16 = 0;

		#100;
      input_16 = 16'b0101010101010101;

		#100;
      input_16 = 16'b1010101010101010;
	end
      
endmodule

