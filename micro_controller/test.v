`timescale 1ns / 1ps

module test;

	// Inputs
	reg clock;
	reg reset;

	// Outputs
	wire [5:0] op;
	wire [17:0] out;
	wire [15:0] ctrl = out[15:2];
	wire [1:0] choice = out[1:0];

	// Instantiate the Unit Under Test (UUT)
	micro_controller uut (
		.clock(clock), 
		.reset(reset), 
		.op(op), 
		.out(out)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		reset = 0;
	end
      
	always begin
		clock = ~clock;
		#25;
	end

endmodule

