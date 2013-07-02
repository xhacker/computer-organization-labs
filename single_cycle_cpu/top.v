`timescale 1ns / 1ps

module top(clock, hand_clock_in, reset_in, disp_sel, disp_anode, disp_seg, led, debug_led);

input wire clock; // the actual clock, for display
input wire reset_in;
wire reset; // anti-jittered

input wire hand_clock_in; // clock for CPU
wire hand_clock; // anti-jittered

debounce debounce_hand_clock(clock, hand_clock_in, hand_clock);
debounce debounce_reset(clock, reset_in, reset);

wire [8:0] o_pc;
wire [8:0] i_pc;
wire [8:0] pc_plus4;
wire [31:0] IR_out;
wire [5:0] opcode;

// Control signals
wire RegDst;
wire Jump;
wire Branch;
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

reg [7:0] hand_clock_count;

// Display related
input wire [6:0] disp_sel;
wire [4:0] test_addr;
assign test_addr[4:0] = disp_sel[6:2];
wire [31:0] test_out;
output wire [4:0] led;
output wire [2:0] debug_led;
output wire [7:0] disp_seg;
output wire [3:0] disp_anode;


always @(posedge hand_clock or posedge reset) begin
	if (reset == 1)
		hand_clock_count = 0;
	else
		hand_clock_count = hand_clock_count + 1'b1;
end

assign opcode = IR_out[31:26];

single_pc single_pc(hand_clock, reset, i_pc, o_pc);
single_pc_plus4 single_pc_plus4(o_pc, pc_plus4);

instruction_mem instruction_mem(.a({2'b00, o_pc[8:2]}), .spo(IR_out));

// Select the reg write destination
mux #(.N(5))mux_write_reg(IR_out[20:16], IR_out[15:11], RegDst, reg_write_reg);

wire J, R, LW, SW, BEQ;
cpu_controller cpu_controller(opcode, ALUOp, RegDst, RegWrite, Branch, MemtoReg, MemWrite, ALUSrc, Jump,
	J, R, LW, SW, BEQ);

gpr gpr(reset, hand_clock,
	IR_out[25:21], IR_out[20:16], test_addr,
	reg_write_reg, reg_write_data, RegWrite,
	reg_data_1, reg_data_2, test_out);

aluc aluc(ALUOp, IR_out[3:0], ALU_oper[2:0]);
sign_extender sign_extender(IR_out[15:0], signext_out);


mux #(.N(32))mux_before_alu(reg_data_2, signext_out, ALUSrc, ALU_in_2);
alu alu(reg_data_1, ALU_in_2, ALU_oper[2:0], ALU_zero, ALU_out);

data_mem data_mem(.a(ALU_out[8:0]), .d(reg_data_2), .clk(hand_clock), .we(MemWrite), .spo(mem_data));

mux #(.N(32))mux_after_alu(ALU_out, mem_data, MemtoReg, reg_write_data);
// for j, jump_addr = addr << 2
assign jump_addr = {4'b0000, IR_out[25:0], 2'b00};
// for beq, if a == b, branch
and_ and_(ALU_zero, Branch, and_out);
add add_branch(o_pc, signext_out << 2, branch_addr);
// pc + 4 or branch
mux #(.N(32))mux_pc4_branch({{23'b00000000000000000000000}, pc_plus4},
	branch_addr, and_out, branch_out);
// branch or jump
mux #(.N(9))mux_before_pc(branch_out[8:0], jump_addr[8:0], Jump, i_pc);


debug_out debug(clock, hand_clock_count, o_pc, test_out, disp_sel[1:0], disp_anode, disp_seg);

// Display instruction types
assign led[0] = J;
assign led[1] = BEQ;
assign led[2] = SW;
assign led[3] = LW;
assign led[4] = R;

// Debug
assign debug_led[2:0] = {ALUOp[1:0], 1'b0};

endmodule
