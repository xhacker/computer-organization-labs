module top(
	input clock,
	input hand_clock_in,
	input reset_in,
	output [1:0] led,
	output [7:0] disp_seg,
	output [3:0] disp_anode
);

	wire [5:0] op;
	wire [17:0] out;
	wire [15:0] ctrl_signals = out[15:2];
	wire [1:0] choice_signals = out[1:0];
	
	wire hand_clock;
	wire reset;
	
	debounce debounce_hand_clock(.clk(clock), .button(hand_clock_in), .button_out(hand_clock));
	debounce debounce_reset(.clk(clock), .button(reset_in), .button_out(reset));
	
	display display(
		.clock(clock),
		.num(ctrl_signals),
		.anode(disp_anode),
		.segment(disp_seg)
	);
	
	assign led = choice_signals;

	micro_controller micro_controller(
		.clock(hand_clock_in),
		.reset(reset_in),
		.op(op),
		.out(out)
	);

endmodule
