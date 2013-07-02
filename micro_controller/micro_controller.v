module micro_controller(
	input clock,
	input reset,
	output reg [5:0] op,
	output reg [17:0] out
);

	reg [3:0] pc;
	reg [3:0] mpc;
	wire [3:0] mpe;
	wire [17:0] ctrl;
	
	initial begin
		pc = 0;
		op = 0;
		mpc = 0;
	end

	mem mem(.clock(clock), .mpc(mpc), .out(ctrl));
	micro_mux mux(.clock(clock), .op(op), .mpc(mpc), .next(ctrl), .out(mpe));

	always @(posedge clock) begin
		if (ctrl[1] == 0 && ctrl[0] == 0) begin
			case (pc)
				0: op <= 6'b000000; // R
				1: op <= 6'b100011; // LW
				2: op <= 6'b101011; // SW
				3: op <= 6'b000100; // BEQ
				4: op <= 6'b000010; // J
				default: op <= 0;
			endcase
		end
	end

	always @(negedge clock or posedge reset) begin
		if (reset) begin
			pc = 0;
			out = 0;
			mpc = 0;
		end else begin
			if ((ctrl[1] == 0 && ctrl[0] == 0) || (pc == 0)) pc = pc + 1;
			mpc = mpe;
			out = ctrl;
		end
	end

endmodule