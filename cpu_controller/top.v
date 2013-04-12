module top(
	input  wire[5:0] OP,
	output wire RegDst,
	output wire ALUsrcB,
	output wire MemToReg,
	output wire WriteReg,
	output wire MemWrite,
	output wire Branch,
	output wire ALUop1,
	output wire ALUop0,
	output wire JMP);

	wire R, LW, SW, BEQ;
	assign R   = ~OP[0] & ~OP[1] & ~OP[2] & ~OP[3] & ~OP[4] & ~OP[5];
	assign LW  =  OP[0] &  OP[1] & ~OP[2] & ~OP[3] & ~OP[4] &  OP[5];
	assign SW  =  OP[0] &  OP[1] & ~OP[2] &  OP[3] & ~OP[4] &  OP[5];
	assign BEQ = ~OP[0] & ~OP[1] &  OP[2] & ~OP[3] & ~OP[4] & ~OP[5];
	assign JMP = ~OP[0] &  OP[1] & ~OP[2] & ~OP[3] & ~OP[4] & ~OP[5];
	
	assign RegDst = R;
	assign ALUsrcB = LW | SW;
	assign MemToReg = LW;
	assign WriteReg = R | LW;
	assign MemWrite = SW;
	assign Branch = BEQ;
	assign ALUop1 = R;
	assign ALUop0 = BEQ;

endmodule
