`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:44:50 04/12/2013
// Design Name:   mul
// Module Name:   D:/3110000420/mul/test.v
// Project Name:  mul
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: mul
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module test;

	// Inputs
	reg [7:0] multiplier;
	reg [7:0] multiplicand;
	reg clock;

	// Outputs
	wire [7:0] result;

	// Instantiate the Unit Under Test (UUT)
	mul uut (
		.multiplier(multiplier), 
		.multiplicand(multiplicand), 
		.clock(clock), 
		.result(result)
	);

	initial begin
		multiplier = 7;
		multiplicand = 8;
		clock = 0;
	end
	
	always
		#100 clock = ~clock;
      
endmodule

