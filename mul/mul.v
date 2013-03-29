`timescale 1ns / 1ps

module mul(
	input [7:0] multiplier,
	input [7:0] multiplicand,
	input clock,
	output reg [7:0] result
    );

	reg [3:0] repetition;
	reg [7:0] multiplier_reg, multiplicand_reg;
	
	initial begin
		repetition = 0;
	end
	
	always @(posedge clock) begin
		if (repetition >= 4) repetition = 0;
		if (repetition == 0) begin
			multiplier_reg = multiplier;
			multiplicand_reg = multiplicand;
			result = 8'h00;
		end
		if (multiplier_reg[0]) result = result + multiplicand_reg;
		multiplicand_reg = multiplicand_reg << 1;
		multiplier_reg = multiplier_reg >> 1;
		repetition = repetition + 1;
	end

endmodule
