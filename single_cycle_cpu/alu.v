`include "includes/alu.vh"

module alu(
	input  wire [31:0] a1,
	input  wire [31:0] a2,
	input  wire [ 2:0] control,
	output wire zero,
	output reg  [31:0] result
);

assign zero = (result == 0) ? 1 : 0;

always @* begin
	case (control)
		`ALU_AND: result = a1 & a2;
		`ALU_OR:  result = a1 | a2;
		`ALU_ADD: result = a1 + a2;
		`ALU_SUB: result = a1 - a2;
		`ALU_SLT: result = (a1 < a2) ? 1 : 0;
		default: result = 32'hx;
	endcase
end

endmodule
