`timescale 1ns / 1ps

module top(
	input clock,
	input [1:0] switch,
	input btn_increase,
	input btn_clock,
	output [7:0] segment,
	output [3:0] anode
    );

	wire btn_increase_out, btn_clock_out;
	debounce d1(clock, btn_increase, btn_increase_out);
	debounce d2(clock, btn_clock, btn_clock_out);
	
	reg [3:0] multiplier, multiplicand;
	initial begin
		multiplier <= 4'h00;
		multiplicand <= 4'h00;
	end
	
	always @(posedge btn_increase_out) begin
		if (switch[1]) multiplier <= multiplier + 1;
		if (switch[0]) multiplicand <= multiplicand + 1;
	end
	
	wire [7:0] result;
	mul m1(multiplier, multiplicand, btn_clock_out, result);
	
	wire [15:0] disp_num;
	assign disp_num = {multiplier, multiplicand, result};
	display disp1(clock, disp_num, segment, anode);

endmodule
