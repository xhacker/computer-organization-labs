`timescale 1ns / 1ps

module top(clock, disp_clock_in, reset_in, disp_sel, disp_anode, disp_seg, led);

input wire clock;
input wire reset_in;
wire reset; // anti-jittered

input wire disp_clock_in;
wire disp_clock; // anti-jittered

debounce _debounce_disp_clock(clock, disp_clock_in, disp_clock);
debounce _debounce_reset(clock, reset_in, reset);

wire [8:0] o_pc;
wire [8:0] i_pc;
wire [8:0] pc_plus4;
wire [31:0] IR_out;
wire [5:0] opcode;

// Control signals
wire RegDst;
wire Jump;
wire Branch;
wire MemRead;
wire MemtoReg;
wire [1:0] ALUOp;
wire MemWrite;
wire ALUSrc;
wire RegWrite;

wire [4:0] reg_write_reg;
wire [31:0] reg_data_1;
wire [31:0] reg_data_2;
wire [2:0] ALU_oper;
wire [31:0] signext_out;
wire [31:0] ALU_in_2;
wire [31:0] ALU_out;
wire ALU_zero;
wire [31:0] mem_data;
wire [31:0] reg_write_data;
wire [31:0] jump_addr;
wire and_out;
wire [31:0] branch_addr;
wire [31:0] branch_out;

reg [15:0] clock_count;
reg [7:0] disp_clock_count;

// Display related
input wire [6:0] disp_sel;
wire [4:0] test_addr;
assign test_addr[4:0] = disp_sel[6:2];
wire [31:0] test_out;
output wire [4:0] led;
output wire [7:0] disp_seg;
output wire [3:0] disp_anode;


always @(posedge clock or posedge reset) begin
	if (reset == 1)
		clock_count = 16'h0000;
	else
		clock_count = clock_count + 1;
end

always @(posedge disp_clock or posedge reset) begin
	if (reset == 1)
		disp_clock_count = 0;
	else
		disp_clock_count = disp_clock_count + 1;
end

assign opcode = IR_out[31:26];

single_pc _single_pc(disp_clock, reset, i_pc, o_pc);
single_pc_plus4 _single_pc_plus4(o_pc, pc_plus4);

instruction_mem _instruction_mem(o_pc[8:2], IR_out);

// Select the reg write destination
mux #(.N(5))_mux_write_reg(IR_out[20:16], IR_out[15:11], RegDst, reg_write_reg);

wire J, R, LW, SW, BEQ;
cpu_controller _cpu_controller(opcode, ALUOp, RegDst, RegWrite, Branch, MemtoReg, MemRead, MemWrite, ALUSrc, Jump,
	J, R, LW, SW, BEQ);

gpr _gpr(reset, disp_clock,
	IR_out[25:21], IR_out[20:16], test_addr,
	reg_write_reg, reg_write_data, RegWrite,
	reg_data_1, reg_data_2, test_out);

aluc _aluc(ALUOp, IR_out[3:0], ALU_oper[2:0]);
sign_extender _sign_extender(IR_out[15:0], signext_out);


mux #(.N(32))_mux_before_alu(reg_data_2, signext_out, ALUSrc, ALU_in_2);
alu _alu(reg_data_1, ALU_in_2, ALU_oper[2:0], ALU_zero, ALU_out);

data_mem _data_mem(ALU_out[8:0], reg_data_2, disp_clock, MemWrite, mem_data);

mux #(.N(32))_mux_after_alu(ALU_out, mem_data, MemtoReg, reg_write_data);
assign jump_addr = {6'b000000, IR_out[25:0]};
and2 _and(ALU_zero, Branch, and_out);
add _add_branch({{23'b00000000000000000000000}, pc_plus4},
	signext_out, branch_addr);
mux _mux_pc4_branch({{23'b00000000000000000000000}, pc_plus4},
	branch_addr, and_out, branch_out);
mux #(.N(9))_mux_before_pc(branch_out[8:0], jump_addr[8:0], Jump, i_pc);


debug_out _debug(clock, disp_clock_count, o_pc, test_out, disp_sel, disp_anode, disp_seg);

// Display instruction types
assign led[0] = J;
assign led[1] = BEQ;
assign led[2] = SW;
assign led[3] = LW;
assign led[4] = R;

endmodule
