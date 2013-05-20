`timescale 1ns / 1ps

module test;

	// Inputs
	reg clock;
	reg [31:0] instruction;

	// Outputs
	wire [31:0] a_data;
	wire [31:0] b_data;
	wire [31:0] result;

	// Instantiate the Unit Under Test (UUT)
	rtype uut (
		.clock(clock), 
		.instruction(instruction), 
		.a_data(a_data), 
		.b_data(b_data), 
		.result(result)
	);

	initial begin
		clock = 0;
		instruction = 0;

		instruction = 32'h01A8_8020;
		#100 clock = ~clock;
		#100 clock = ~clock;

		instruction = 32'h01C9_8822;
		#100 clock = ~clock;
		#100 clock = ~clock;

		instruction = 32'h01EA_9024;
		#100 clock = ~clock;
		#100 clock = ~clock;

		instruction = 32'h030B_9825;
		#100 clock = ~clock;
		#100 clock = ~clock;

		instruction = 32'h032C_A02A;
		#100 clock = ~clock;
		#100 clock = ~clock;
	end
      
endmodule

