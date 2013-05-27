`timescale 1ns / 1ps

module mux_test;

	reg [0:0] a;
	reg [0:0] b;
	reg control;
	wire [0:0] out;

	mux uut (
		.a(a), 
		.b(b), 
		.control(control), 
		.out(out)
	);

	initial begin
		a = 0;
		b = 1;
		control = 0;

		#100;
		control = 1;
	end
      
endmodule

