module test;

	// Inputs
	reg [5:0] OP;

	// Outputs
	wire RegDst;
	wire ALUsrcB;
	wire MemToReg;
	wire WriteReg;
	wire MemWrite;
	wire Branch;
	wire ALUop1;
	wire ALUop0;
	wire JMP;

	// Instantiate the Unit Under Test (UUT)
	top uut (
		.OP(OP), 
		.RegDst(RegDst), 
		.ALUsrcB(ALUsrcB), 
		.MemToReg(MemToReg), 
		.WriteReg(WriteReg), 
		.MemWrite(MemWrite), 
		.Branch(Branch), 
		.ALUop1(ALUop1), 
		.ALUop0(ALUop0), 
		.JMP(JMP)
	);

	initial begin
		// Initialize Inputs
		OP = 0;

		// Wait 100 ns for global reset to finish
		#100;
		
		OP = 6'b000000; // R
		#200
		OP = 6'b100011; // LW
		#200
		OP = 6'b101011; // SW
		#200
		OP = 6'b000100; // BEQ
		#200
		OP = 6'b000010; // JMP

	end
      
endmodule

