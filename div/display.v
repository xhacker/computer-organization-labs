module display(
	input clock,
	input [15:0] num,
	output reg [7:0] segment,
	output reg [3:0] anode
	);

reg [5:0]  code  =  4'b0;
reg [15:0] count = 15'b0;

always @(posedge clock) begin
	case (count[15:14])
		2'b00 : begin
			anode <= 4'b1110; 
			code <= num[3:0];
		end
		2'b01 : begin
			anode <= 4'b1101;
			code <= num[7:4];
		end
		2'b10 : begin
			anode <= 4'b1011;
			code <= num[11:8];
		end
		2'b11 : begin
			anode <= 4'b0111;
			code <= num[15:12];
		end
	endcase
	case (code)
		4'b0000: segment <= 8'b11000000;
		4'b0001: segment <= 8'b11111001;
		4'b0010: segment <= 8'b10100100;
		4'b0011: segment <= 8'b10110000;
		4'b0100: segment <= 8'b10011001;
		4'b0101: segment <= 8'b10010010;
		4'b0110: segment <= 8'b10000010;
		4'b0111: segment <= 8'b11111000;
		4'b1000: segment <= 8'b10000000;
		4'b1001: segment <= 8'b10010000;
		4'b1010: segment <= 8'b10001000;
		4'b1011: segment <= 8'b10000011;
		4'b1100: segment <= 8'b11000110;
		4'b1101: segment <= 8'b10100001;
		4'b1110: segment <= 8'b10000110;
		4'b1111: segment <= 8'b10001110;
		default: segment <= 8'b11111111;
	endcase
	count <= count + 1;
end

endmodule
