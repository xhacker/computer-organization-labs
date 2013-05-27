`timescale 1ns / 1ps

module mux_fpgatest(
	input  [7:0] switch,
	input  button,
	output [3:0] led
);

	mux m1(switch[7:4], switch[3:0], button, led);

endmodule
