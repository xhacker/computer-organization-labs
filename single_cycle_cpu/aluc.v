`include "includes/alu.vh"

module aluc(
	input wire [1:0] aluop,
	input wire [3:0] func_code,
	output reg [2:0] control
);
	
always @* begin

	case (aluop)
		2'b00: control <= `ALU_ADD;
		2'b01: control <= `ALU_SUB;
		default: begin
			case (func_code)
				4'b0000: control <= `ALU_ADD;
				4'b0010: control <= `ALU_SUB;
				4'b0100: control <= `ALU_AND;
				4'b0101: control <= `ALU_OR;
				4'b1010: control <= `ALU_SLT;
			endcase
		end
	end

end

endmodule
