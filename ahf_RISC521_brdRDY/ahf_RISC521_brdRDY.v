// Copyright (C) 2016  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel MegaCore Function License Agreement, or other 
// applicable license agreement, including, without limitation, 
// that your use is for the sole purpose of programming logic 
// devices manufactured by Intel and sold by Intel or its 
// authorized distributors.  Please refer to the applicable 
// agreement for further details.

// PROGRAM		"Quartus Prime"
// VERSION		"Version 16.1.0 Build 196 10/24/2016 SJ Lite Edition"
// CREATED		"Fri Dec 02 10:57:17 2016"

module ahf_RISC521_brdRDY(
	CLOCK_50,
	Reset,
	SW,
	DISP,
	R12
);


input wire	CLOCK_50;
input wire	Reset;
input wire	[4:0] SW;
output wire	[3:0] DISP;
output wire	[3:0]	R12;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;





ahf_mainpll	b2v_inst(
	.inclk0(CLOCK_50),
	.c0(SYNTHESIZED_WIRE_0),
	.c1(SYNTHESIZED_WIRE_1),
	.c2(SYNTHESIZED_WIRE_2));


ahf4722_RISC521_v	b2v_inst1(
	.Reset_pin(Reset),
	.Clk_pin0(SYNTHESIZED_WIRE_0),
	.Clk_pin1(SYNTHESIZED_WIRE_1),
	.Clk_pin2(SYNTHESIZED_WIRE_2),
	.SW_pin(SW),
	.Disp_pin(DISP),
	.R12out(R12));
	defparam	b2v_inst1.ADD_IC = 4'b0101;
	defparam	b2v_inst1.ADDC_IC = 4'b0111;
	defparam	b2v_inst1.ADDV_IC = 4'b1110;
	defparam	b2v_inst1.AND_IC = 4'b1010;
	defparam	b2v_inst1.CPY_IC = 4'b0010;
	defparam	b2v_inst1.JC0 = 4'b0111;
	defparam	b2v_inst1.JC1 = 4'b1000;
	defparam	b2v_inst1.JMP_IC = 4'b0100;
	defparam	b2v_inst1.JN0 = 4'b1011;
	defparam	b2v_inst1.JN1 = 4'b0100;
	defparam	b2v_inst1.JU = 4'b0000;
	defparam	b2v_inst1.JV0 = 4'b1101;
	defparam	b2v_inst1.JV1 = 4'b0010;
	defparam	b2v_inst1.JZ0 = 4'b1110;
	defparam	b2v_inst1.JZ1 = 4'b0001;
	defparam	b2v_inst1.LD_IC = 4'b0000;
	defparam	b2v_inst1.NOT_IC = 4'b1001;
	defparam	b2v_inst1.OR_IC = 4'b1011;
	defparam	b2v_inst1.ROTR_IC = 4'b1101;
	defparam	b2v_inst1.SHRA_IC = 4'b1100;
	defparam	b2v_inst1.ST_IC = 4'b0001;
	defparam	b2v_inst1.SUB_IC = 4'b0110;
	defparam	b2v_inst1.SUBC_IC = 4'b1000;
	defparam	b2v_inst1.SWAP_IC = 4'b0011;

		
	
	

endmodule
