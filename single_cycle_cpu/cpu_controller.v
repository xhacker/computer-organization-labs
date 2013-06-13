module cpu_controller(
	input  wire[5:0] OP,
	output wire[1:0] ALUOp,
	output wire RegDst,
	output wire RegWrite,
	output wire Branch,
	output wire MemtoReg,
	output wire MemRead,
	output wire MemWrite,
	output wire ALUSrc,
	output wire Jump
);

	wire R, LW, SW, BEQ;
	assign R   = ~OP[0] & ~OP[1] & ~OP[2] & ~OP[3] & ~OP[4] & ~OP[5];
	assign LW  =  OP[0] &  OP[1] & ~OP[2] & ~OP[3] & ~OP[4] &  OP[5];
	assign SW  =  OP[0] &  OP[1] & ~OP[2] &  OP[3] & ~OP[4] &  OP[5];
	assign BEQ = ~OP[0] & ~OP[1] &  OP[2] & ~OP[3] & ~OP[4] & ~OP[5];
	assign JMP = ~OP[0] &  OP[1] & ~OP[2] & ~OP[3] & ~OP[4] & ~OP[5];

	assign ALUOp = {R, BEQ};
	assign RegDst = R;
	assign RegWrite = R | LW;
	assign Branch = BEQ;
	assign MemtoReg = LW;
	assign MemRead = LW;
	assign MemWrite = SW;
	assign ALUSrc = LW | SW;
	assign Jump = JMP;

endmodule
