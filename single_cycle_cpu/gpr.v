// general purpose registers

module gpr(
	input reset,
	input clock,
	input [4:0] i_addr_1,
	input [4:0] i_addr_2,
	input [4:0] i_addr_3, // for test purpose
	input [4:0] i_write_reg,
	input [31:0] i_write_data,
	input i_write_enable,
	output [31:0] o_read_data_1,
	output [31:0] o_read_data_2,
	output [31:0] o_read_data_3 // for test purpose
);

	reg [31:0] mem[31:0];
	
	assign o_read_data_1 = mem[i_addr_1];
	assign o_read_data_2 = mem[i_addr_2];
	assign o_read_data_3 = mem[i_addr_3];

	always @(posedge clock or posedge reset) begin
		if (reset)
			mem[0] <= 32'h00000000;
		else if (i_write_enable)
			mem[i_write_reg] <= (i_write_reg == 5'b00000) ? 32'h00000000 : i_write_data;
	end

endmodule