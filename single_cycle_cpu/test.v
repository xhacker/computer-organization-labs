`timescale 1ns / 1ps

module test;

	// Inputs
	reg clock;
	reg disp_clock_in;
	reg reset_in;
	reg [6:0] disp_sel;

	// Outputs
	wire [5:0] led;
	wire [3:0] disp_anode;
	wire [7:0] disp_seg;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.clock(clock), 
		.disp_clock_in(disp_clock_in), 
		.reset_in(reset_in), 
		.disp_sel(disp_sel), 
		.led(led), 
		.disp_anode(disp_anode), 
		.disp_seg(disp_seg)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		disp_clock_in = 0;
		reset_in = 0;
		disp_sel = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here

	end
      
endmodule

