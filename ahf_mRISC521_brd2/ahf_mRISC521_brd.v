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

module ahf_mRISC521_brd(
	CLOCK_50,
	Reset,
	SW,
	DISP,
	R12
);


input wire	CLOCK_50;
input wire	Reset;
input wire	[4:0] SW;
output wire	[7:0] DISP;
output wire [1:0]R12;

wire	SYNTHESIZED_WIRE_0;
wire	SYNTHESIZED_WIRE_1;
wire	SYNTHESIZED_WIRE_2;
wire 	[2:0] Read, Done_master;
wire	[2:0] Write, Done_slave;
wire	[41:0] DataToMaster;
wire	[13:0] DataFromMaster;





ahf_mainpll	b2v_inst(
	.inclk0(CLOCK_50),
	.c0(SYNTHESIZED_WIRE_0),
	.c1(SYNTHESIZED_WIRE_1),
	.c2(SYNTHESIZED_WIRE_2));


ahf4722_RISC521_v #(.mif_master("masterv4.mif"))	master(
	.Reset_pin(Reset),
	.Clk_pin0(SYNTHESIZED_WIRE_0),
	.Clk_pin1(SYNTHESIZED_WIRE_1),
	.Clk_pin2(SYNTHESIZED_WIRE_2),
	.SW_pin(SW),
	.Data_in(DataToMaster),
	.Data_out(DataFromMaster),
	.Disp_pin(DISP),
	.Write(Write),
	.Read(Read),
	.Done_in(Done_slave),
	.Done_out(Done_master),
	.R12out(R12));
	
ahf4722_RISC521_slave #(.mif_slave("slave0v3.mif")) slave0 (
	.Reset_pin(Reset),
	.Clk_pin0(SYNTHESIZED_WIRE_0),
	.Clk_pin1(SYNTHESIZED_WIRE_1),
	.Clk_pin2(SYNTHESIZED_WIRE_2),
	.Data_in(DataFromMaster),
	.Data_out(DataToMaster[13:0]),
	.Write(Write[0]),
	.Read(Read[0]),
	.Done_in(Done_master[0]),
	.Done_out(Done_slave[0]));
	
ahf4722_RISC521_slave #(.mif_slave("slave1v3.mif"))	slave1 (
	.Reset_pin(Reset),
	.Clk_pin0(SYNTHESIZED_WIRE_0),
	.Clk_pin1(SYNTHESIZED_WIRE_1),
	.Clk_pin2(SYNTHESIZED_WIRE_2),
	.Data_in(DataFromMaster),
	.Data_out(DataToMaster[27:14]),
	.Write(Write[1]),
	.Read(Read[1]),
	.Done_in(Done_master[1]),
	.Done_out(Done_slave[1]));
	
ahf4722_RISC521_slave #(.mif_slave("slave2v3.mif"))	slave2 (
	.Reset_pin(Reset),
	.Clk_pin0(SYNTHESIZED_WIRE_0),
	.Clk_pin1(SYNTHESIZED_WIRE_1),
	.Clk_pin2(SYNTHESIZED_WIRE_2),
	.Data_in(DataFromMaster),
	.Data_out(DataToMaster[41:28]),
	.Write(Write[2]),
	.Read(Read[2]),
	.Done_in(Done_master[2]),
	.Done_out(Done_slave[2]));
//	
//	defparam	master.ADD_IC = 4'b0101;
//	defparam	master.ADDC_IC = 4'b0111;
//	defparam	master.ADDV_IC = 4'b1110;
//	defparam	master.AND_IC = 4'b1010;
//	defparam	master.CPY_IC = 4'b0010;
//	defparam	master.JC0 = 4'b0111;
//	defparam	master.JC1 = 4'b1000;
//	defparam	master.JMP_IC = 4'b0100;
//	defparam	master.JN0 = 4'b1011;
//	defparam	master.JN1 = 4'b0100;
//	defparam	master.JU = 4'b0000;
//	defparam	master.JV0 = 4'b1101;
//	defparam	master.JV1 = 4'b0010;
//	defparam	master.JZ0 = 4'b1110;
//	defparam	master.JZ1 = 4'b0001;
//	defparam	master.LD_IC = 4'b0000;
//	defparam	master.NOT_IC = 4'b1001;
//	defparam	master.OR_IC = 4'b1011;
//	defparam	master.ROTR_IC = 4'b1101;
//	defparam	master.SHRA_IC = 4'b1100;
//	defparam	master.ST_IC = 4'b0001;
//	defparam	master.SUB_IC = 4'b0110;
//	defparam	master.SUBC_IC = 4'b1000;
//	defparam	master.SWAP_IC = 4'b0011;

		
	
	

endmodule
