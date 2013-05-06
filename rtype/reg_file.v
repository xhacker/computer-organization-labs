`timescale 1ns / 1ps

module reg_file(
	input clock,
	input [4:0] a_addr,
	input [4:0] b_addr,
	input [4:0] w_addr,
	input [31:0] w_data,
	output [31:0] a_data,
	output [31:0] b_data,
	input reg_write
);

reg [31:0] register [1:31];

assign a_data = (a_addr == 0) ? 0 : register[a_addr];
assign b_data = (b_addr == 0) ? 0 : register[b_addr];

integer i;
initial begin
	for (i = 1; i < 32; i = i + 1)
		register[i] <= i;
end

always @(posedge clock) begin
	if ((w_addr != 0) && (reg_write == 1))
		register[w_addr] <= w_data;
end

endmodule
