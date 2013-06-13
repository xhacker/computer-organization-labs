module alu(
	input wire [31:0] a1,
	input wire [31:0] a2,
	input wire [ 2:0] control,
	output reg zero,
	output reg [31:0] result
);

always @* begin
	case (control)
		3'b000: begin
			zero = 0;
			result = a1 & a2;
		end
		3'b001: begin
			zero = 0;
			result = a1 | a2;
		end
		3'b010: begin
			zero = 0;
			result = a1 + a2;
		end
		3'b110: begin
			result = a1 - a2;
			zero = (result == 0);
		end
		3'b111: begin
			zero = 0;
			result = (a1 < a2) ? 1 : 0;
		end
		default: begin
			zero = 0;
			result = 0;
		end
	endcase
end

endmodule
