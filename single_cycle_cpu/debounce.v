`timescale 1ns / 1ps

module debounce(
	input clk,
	input button,
	output reg button_out
    );

	localparam threshold = 1000000;

	reg [20:0] cnt;

	always @(posedge clk) begin
		if (button == 0) begin
			button_out = 0;
			cnt = 0;
		end
		else begin
			if (cnt < threshold)
				cnt = cnt + 1;
			else
				button_out = 1;
		end
	end

endmodule
