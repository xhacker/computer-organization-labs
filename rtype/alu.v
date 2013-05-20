module alu(
	input wire [31:0] a1,
	input wire [31:0] a2,
	input wire [ 2:0] control,
	output reg [31:0] result
);

always @* begin
	case (control)
		3'b000 : result <= a1 & a2;
		3'b001 : result <= a1 | a2;
		3'b010 : result <= a1 + a2;
		3'b110 : result <= a1 - a2;
		3'b111 : result <= (a1 < a2) ? 4'b0001 : 4'b0000;
	endcase
end

endmodule
