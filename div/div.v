`timescale 1ns / 1ps

module div(
	input [3:0] dividend_in,
	input [3:0] divisor_in,
	input clock,
	output reg [3:0] quotient,
	output reg [3:0] remainder
    );

	reg [3:0] repetition;
	
	initial begin
		repetition = 0;
	end
	
	reg [3:0] dividend, divisor;
	
	always @(posedge clock) begin
		if (repetition >= 5) repetition = 0;
		if (repetition == 0) begin
			dividend = dividend_in;
			divisor = divisor_in;
			remainder = dividend;
			quotient = 0;
		end
		
		remainder = remainder - divisor;
		if (remainder >= 0) begin
			quotient = quotient << 1;
			quotient[0] = 1'b1;
		end else begin
			remainder = remainder + divisor;
			quotient = quotient << 1;
			quotient[0] = 1'b0;
		end
		divisor = divisor >> 1;
		repetition = repetition + 1;
	end

endmodule
