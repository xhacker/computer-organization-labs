`timescale 1ns / 1ps

module pc_test;

	// Inputs
	reg clock;
	reg reset;

	// Outputs
	wire [8:0] i_pc;
	wire [8:0] o_pc;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clock(clock), 
		.reset(reset), 
		.i_pc(i_pc), 
		.o_pc(o_pc)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		reset = 1;

		#100 clock = 1;
		#100 clock = 0;
		
		reset = 0;
		
		#100 clock = 1;
		#100 clock = 0;
		#100 clock = 1;
		#100 clock = 0;
		#100 clock = 1;
		
		reset = 1;
		
		#100 clock = 0;
		#100 clock = 1;
	end
      
endmodule

