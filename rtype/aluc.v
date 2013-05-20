module aluc(
	input wire [1:0] aluop,
	input wire [3:0] func_code,
	output reg [2:0] control
);
	
always @* begin

	if (aluop[0] == 0) begin
		if (aluop[1] == 0) control <= 3'b010;
		else control <= 3'b110;
	end else begin
		case (func_code)
			4'b0000 : control <= 3'b010;
			4'b0010 : control <= 3'b110;
			4'b0100 : control <= 3'b000;
			4'b0101 : control <= 3'b001;
			4'b1010 : control <= 3'b111;
		endcase
	end

end

endmodule
