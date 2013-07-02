module micro_mux(
	input clock,
	input [5:0] op,
	input [3:0] mpc,
	input [1:0] next,
	output reg [3:0] out
);

	always @(posedge clock) begin
		if (next[1] == 0) begin
			if (next[0] == 0) begin // 00
				out <= 0;
			end else begin  // 01
				case (op)
					6'b100011: out <= 2; // LW
					6'b101011: out <= 2; // SW
					6'b000000: out <= 6; // R
					6'b000100: out <= 8; // BEQ
					6'b000010: out <= 9; // J
					default:   out <= 0;
				endcase
			end
		end
		else begin
			if (next[0] == 0) begin // 10
				case (op)
					6'b100011: out <= 3;
					6'b101011: out <= 5;
					default:   out <= 0;
				endcase
			end else begin // 11
				out <= mpc + 1;
			end
		end
	end

endmodule
