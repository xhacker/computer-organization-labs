`timescale 1ns / 1ps

module top(
	input clock,
	input btn_increast_dividend,
	input btn_increase_divisor,
	input btn_clock,
	output [7:0] segment,
	output [3:0] anode
    );

	wire btn_increase_out, btn_clock_out;
	debounce btn1(clock, btn_increast_dividend, btn_increast_dividend_out);
	debounce btn2(clock, btn_increase_divisor, btn_increase_divisor_out);
	debounce btn3(clock, btn_clock, btn_clock_out);
	
	reg [3:0] dividend, divisor;
	initial begin
		dividend <= 4'h00;
		divisor <= 4'h00;
	end
	
	always @(posedge btn_increast_dividend_out) begin
		dividend <= dividend + 1;
	end
	
	always @(posedge btn_increase_divisor_out) begin
		divisor <= divisor + 1;
	end
	
	wire [3:0] quotient, remainder;
	div d1(dividend, divisor, btn_clock_out, quotient, remainder);
	
	wire [15:0] disp_num;
	assign disp_num = {dividend, divisor, quotient, remainder};
	display disp1(clock, disp_num, segment, anode);

endmodule
