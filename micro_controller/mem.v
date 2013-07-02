module mem(clock, mpc, out);

	input wire clock;
	input wire [3:0] mpc;
	output reg [17:0] out;

	always @(*) begin
		case (mpc)
			0: out <= 18'b000010000101000111;
			1: out <= 18'b000110000000000001;
			2: out <= 18'b000100000000000010;
			3: out <= 18'b000000001100000011;
			4: out <= 18'b000000110000000000;
			5: out <= 18'b000000001010000000;
			6: out <= 18'b101000000000000011;
			7: out <= 18'b000001010000000000;
			8: out <= 18'b011000000000011000;
			9: out <= 18'b000000000000100100;
			default: out <= 18'b000010000101000111;
		endcase
	end
	
endmodule
