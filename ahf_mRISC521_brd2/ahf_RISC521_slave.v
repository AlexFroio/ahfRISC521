module ahf4722_RISC521_slave #(parameter mif_slave) (Reset_pin, Clk_pin0, Clk_pin1, Clk_pin2, Data_in, Data_out, Read, Write, Done_in, Done_out);
	input Reset_pin, Clk_pin0, Clk_pin1, Clk_pin2;
	input [13:0] Data_in; // 4 switches, 1 push button
	output [13:0] Data_out; //8 LEDs
	output Done_out;
	input Read, Write, Done_in;
//-----------------------------------------------------
//-- Declare Machine Cycles + instr. cycle parameters
//-----------------------------------------------------
	parameter [3:0] LD_IC=4'b0000, ST_IC=4'b0001, CPY_IC=4'b0010, SWAP_IC=4'b0011, 
		JMP_IC=4'b0100, ADD_IC=4'b0101, SUB_IC=4'b0110, ADDC_IC=4'b0111, 
		SUBC_IC =4'b1000, NOT_IC=4'b1001, AND_IC=4'b1010, OR_IC=4'b1011, 
		SHRA_IC=4'b1100, ROTR_IC=4'b1101, ADDV_IC = 4'b1110;
	parameter [3:0] JU=4'b0000, JC1=4'b1000, JN1=4'b0100, JV1=4'b0010, 
		JZ1=4'b0001, JC0=4'b0111, JN0=4'b1011, JV0=4'b1101, JZ0=4'b1110;
//----------------------------------------------------------------------------
//-- Declare internal signals
//-- Specs: 14-bit words, 8-bit SR, 32 gen.-purpose Registers, 1 Phys address mode
//-- Memory range 0x3F00 to 0x3FFF
//----------------------------------------------------------------------------
	reg [13:0] R [31:0];
	reg [4:0] holdReg;
	reg  WR_DM, stall_mc0, stall_mc1, stall_mc2, stall_mc3, datastall, Done_out;
	reg [13:0] PgCnt, IR3, IR2, IR1, MAB, MAX, MAeff, PMeff, SP, DM_in, PCntr,  Data_out;
	reg [13:0] TA, TB, TALUH, TALUL;
	reg [7:0] TSR, SR, TAV1out, TAV2out;
//	reg [7:0] Disp_pin;
	reg [14:0] TALUout;
	wire [13:0] PM_out, DM_out, Data_in;
	wire			romstall, ramstall;
	wire 			C, Clk_not0, Clk_not1, Clk_not2, TX_in, RX_in;
	integer Ri1, Rj1, Ri2, Rj2, Ri3, Rj3, i;
	
	assign Clk_not0 = ~Clk_pin0;
	assign Clk_not1 = ~Clk_pin1;
	assign Clk_not2 = ~Clk_pin2;
//	assign R12out = R[12];
// Instantiated 1k word memories to save resources:
	ahf_crom_v #(.mif_file(mif_slave)) my_crom  (PgCnt[13:0], Clk_not0, Clk_not1, Clk_not2, 14'b0, 1'b0, Reset_pin, romstall, PM_out);
	ahf_cram_v my_cram (MAeff[13:0], Clk_not0, Clk_not1, Clk_not2, DM_in, WR_DM, Reset_pin, ramstall, DM_out);
	
	always@(posedge Clk_pin0)
	
		
		if(Reset_pin == 0)
			begin
			PgCnt = 14'h0000;
			for (i = 0; i < 32 ; i = i + 1)
				begin
					R[i] = 0; //Necessary for sims
				end
// Initialize stall_mc signals for pipeline startup
			stall_mc0 = 0; 
			stall_mc1 = 1; stall_mc2 = 1; stall_mc3 = 1;
			IR1 = 14'h3FFF; IR2 = 14'h3FFF; IR3 = 14'h3FFF;
			WR_DM = 0; holdReg = 5'h00;
			MAeff = 14'h0000;
			SR = 8'h00;
			TSR = 8'h00;
			Ri1 = 0; Ri2 = 0; Ri3 =0;
			TA = 0; TB = 0; TALUH = 0; MAB = 0; MAX = 0;
			TALUH = 0; TALUL = 0; PMeff = 0;
			Done_out = 0; datastall = 0;
			Data_out = 14'h0000;
			end
		else if(romstall == 1|| ramstall == 1 || datastall == 1 ) begin
			PCntr = PCntr + 1'b1;
			if (datastall == 1 && Write == 1) begin
				R[holdReg] = Data_in;
				datastall = 0;
				Done_out = 0;
			end 
			else if (datastall == 1 && Read == 1) begin
				Done_out = 0;
				datastall = 0;
			end
		end
		else begin
//============================================================================
// 		Below is MC3, it executes first in case MC2 needs any data from it
//============================================================================
			PCntr = PCntr + 1'b1;
			if (Read == 1 || Write == 1) Done_out = 1;
			if (stall_mc3 == 0) 
				begin 
					case (IR3[13:10])
						LD_IC:
							begin
								if (MAeff[13:8] == 6'h3F)
									if (MAeff[3:0] == 4'hF)
										R[IR3[4:0]] = SP;
									else begin
										if (Write == 1) begin
											R[IR3[4:0]] = Data_in; Done_out = 0;
										end
										else begin 
											holdReg = IR3[4:0];
											datastall = 1; Done_out = 1;
										end
									end
								else
									R[IR3[4:0]] = DM_out;
							end
						ST_IC:
							begin
								WR_DM = 1'B0;
								if (MAeff[13:8] == 6'h3F) begin
									if (MAeff[3:0] == 4'hF)
										SP = R[IR3[4:0]];
									else begin
//										if (Read == 1) begin
//											Data_out = R[IR3[4:0]]; Done_out = 0;
//										end 
//										else begin
											Data_out = R[IR3[4:0]];
											datastall = 1; Done_out = 1;
//										end
									end
								end
								else DM_in = R[IR3[4:0]];
							end
						CPY_IC:
							begin
								R[IR3[9:5]] = TALUL;
							end
						SWAP_IC:
							begin
								R[IR3[9:5]] = TALUL;
								R[IR3[4:0]] = TALUH;
							end
						JMP_IC:
							begin
								case(IR3[4:1])
									JU:
										begin
											PgCnt = PgCnt + PMeff; //Intentional to make forward and backwards jumps easier
										end
									JC1:
										begin
											if (SR[7] == 1)
											PgCnt = PgCnt + PMeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JC0:
										begin
											if (SR[7] == 0)
											PgCnt = PgCnt + PMeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JN1:
										begin
											if (SR[6] == 1)
											PgCnt = PgCnt + PMeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JN0:
										begin
											if (SR[6] == 0)
											PgCnt = PgCnt + PMeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JV1:
										begin
											if (SR[5] == 1)
											PgCnt = PgCnt + PMeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JV0:
										begin
											if (SR[5] == 0)
											PgCnt = PgCnt + PMeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JZ1:
										begin
											if (SR[4] == 1)
											PgCnt = PgCnt + PMeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JZ0:
										begin
											if (SR[4] == 0)
											PgCnt = PgCnt + PMeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
								endcase
							end
						ADD_IC, ADDC_IC, ADDV_IC, SUB_IC, SUBC_IC, NOT_IC, AND_IC, OR_IC, SHRA_IC, ROTR_IC:
							begin
								R[Ri3] = TALUH;
								SR = TSR;
							end
						default: ;
					endcase
				end
//============================================================================
// 		Below is MC2
//============================================================================
			if (stall_mc2 == 0) 
				begin
					case (IR2[13:10])
						ADDV_IC:
							begin
								TAV1out = TA[13:7] + TB[13:7];
								TAV2out = TA[6:0] + TB[6:0];
								TSR[7] = TAV1out[7];
								TSR[3] = TAV2out[7];
								TSR[6] = TAV1out[6];
								TSR[2] = TAV2out[6];
								TSR[5] = ((TA[13] ~^ TB[13]) & TA[13]) ^ (TAV1out[7] & (TA[13] ~^ TB[13]));
								TSR[1] = ((TA[6] ~^ TB[6]) & TA[6]) ^ (TAV2out[7] & (TA[6] ~^ TB[6]));
								if(TAV1out[6:0] == 14'h0000)
									TSR[4] = 1; // Zero
								else
									TSR[4] = 0;
								if(TAV2out[6:0] == 14'h0000)
									TSR[0] = 1; // Zero
								else
									TSR[0] = 0;
								TALUH = {TAV1out[6:0], TAV2out[6:0]};
							end
						ADD_IC, ADDC_IC:
							begin
								TALUout = TA + TB;
								TSR[7] = TALUout[14]; // carry
								TSR[6] = TALUout[13]; // -ve
								TSR[5] = ((TA[13] ~^ TB[13]) & TA[13]) ^ (TALUout[13] & (TA[13] ~^ TB[13])); // Overflow
								if(TALUout[13:0] == 14'h0000)
									TSR[4] = 1; // Zero
								else
									TSR[4] = 0;
								TALUH = TALUout[13:0];
							end
						SUB_IC, SUBC_IC:
							begin
								TALUout = TA - TB;
								TSR[7] = TALUout[14]; // carry
								TSR[6] = TALUout[13]; // -ve
								TSR[5] = ((TA[13] ~^ TB[13]) & TA[13]) ^ (TALUout[13] & (TA[13] ~^ TB[13]));
								if(TALUout[13:0] == 14'h0000)
									TSR[4] = 1; // Zero
									else
									TSR[4] = 0;
								TALUH = TALUout[13:0];
							end
						OR_IC:
							begin
								TALUH = TA | TB;
								TSR[6] = TALUH[13]; //-ve
								if(TALUH[13:0] == 14'h0000)
									TSR[4] = 1; // Zero
								else
									TSR[4] = 0;
							end
						AND_IC:
							begin
								TALUH = TA & TB;
								TSR[6] = TALUH[13]; //-ve
								if(TALUH[13:0] == 14'h0000)
									TSR[4] = 1; // Zero
								else
									TSR[4] = 0;
							end
						NOT_IC:
							begin
								TALUH = ~TA;
							end
						SHRA_IC:
							begin
								if (IR2[4] == 0) begin
									TALUH = TA >>> IR2[3:0];
									end
								else if (IR2[4] == 1) begin
									TALUH = TA <<< (~IR2[3:0] + 1'b1);
									end
							end
						ROTR_IC:
							begin case (IR2[4:0])
								5'h00: begin TALUH = TA; end
								5'h01: begin TALUH[13] = TSR[7]; TALUH[12:0] = TA[13:1];TSR[7] = TA[0]; end
								5'h02: begin TALUH[13] = TA[0]; TALUH[12] = TSR[7]; TALUH[11:0] = TA[13:2]; TSR[7] = TA[1]; end
								5'h03: begin TALUH[13:12] = TA[1:0]; TALUH[11] = TSR[7]; TALUH[10:0] = TA[13:3]; TSR[7] = TA[2]; end
								5'h04: begin TALUH[13:11] = TA[2:0]; TALUH[10] = TSR[7]; TALUH[9:0] = TA[13:4]; TSR[7] = TA[3]; end
								5'h05: begin TALUH[13:10] = TA[3:0]; TALUH[9] = TSR[7]; TALUH[8:0] = TA[13:5]; TSR[7] = TA[4]; end
								5'h06: begin TALUH[13:9] = TA[4:0]; TALUH[8] = TSR[7]; TALUH[7:0] = TA[13:6]; TSR[7] = TA[5]; end
								5'h07: begin TALUH[13:8] = TA[5:0]; TALUH[7] = TSR[7]; TALUH[6:0] = TA[13:7]; TSR[7] = TA[6]; end
								5'h08: begin TALUH[13:7] = TA[6:0]; TALUH[6] = TSR[7]; TALUH[5:0] = TA[13:8]; TSR[7] = TA[7]; end
								5'h09: begin TALUH[13:6] = TA[7:0]; TALUH[5] = TSR[7]; TALUH[4:0] = TA[13:9]; TSR[7] = TA[8]; end
								5'h0A: begin TALUH[13:5] = TA[8:0]; TALUH[4] = TSR[7]; TALUH[3:0] = TA[13:10]; TSR[7] = TA[9]; end
								5'h0B: begin TALUH[13:4] = TA[9:0]; TALUH[3] = TSR[7]; TALUH[2:0] = TA[13:11]; TSR[7] = TA[10]; end
								5'h0C: begin TALUH[13:3] = TA[10:0]; TALUH[2] = TSR[7]; TALUH[1:0] = TA[13:12]; TSR[7] = TA[11]; end
								5'h0D: begin TALUH[13:2] = TA[11:0]; TALUH[1] = TSR[7]; TALUH[0] = TA[13]; TSR[7] = TA[12]; end
								5'h0E: begin TALUH[13:1] = TA[12:0]; TALUH[0] = TSR[7]; TSR[7] = TA[13]; end
								5'h0F: begin TALUH = TA; end
							endcase
							end
						LD_IC:
							begin
								MAeff = MAB + MAX;
								WR_DM = 1'b0;
							end
						JMP_IC:
							begin
								PMeff = MAB + MAX;
								WR_DM = 1'b0;
							end
						ST_IC:
							begin
								MAeff = MAB + MAX;
								if (MAeff[13:12] != 6'h3) begin
									WR_DM = 1'b1; 
									if (Rj2 == Ri3 && (IR3[13:10] != LD_IC || IR3[13:10] != ST_IC || IR3[13:10] != JMP_IC)) 
										DM_in = R[Ri3];
									else if (Rj2 == Rj3 && IR3[13:10] == SWAP_IC) 
										DM_in = R[Rj3];
									else DM_in = R[Rj2];
									end
								else WR_DM = 1'b0; 
							end
						CPY_IC:
							begin
								TALUL = TB;
							end
						SWAP_IC:
							begin
								TALUH = TA;
								TALUL = TB;
							end
						default:
							;
					endcase
				end
//============================================================================
// 		Below is MC1
//============================================================================
			if (stall_mc1 == 0) 
				begin
					case (IR1[13:10])
						ADDC_IC, SUBC_IC:
							begin
								if (Ri1 == Ri2 && IR2 != 14'h3fff) begin 
									TA = TALUH; TB = {9'h0000, IR1[4:0]}; 
								end
								else begin
									TA = R[Ri1];
									TB = {9'h0000, IR1[4:0]};
								end
							end
						NOT_IC, SHRA_IC, ROTR_IC:
							begin
								if (Ri1 == Ri2) begin
									TA = TALUH;
									end
								//else if (Ri1 == Rj2) TA = TALUH;
								else begin 
									TA = R[Ri1];
								end
							end
						CPY_IC:
							begin
								if (Rj1 == Rj2) TB = TALUH;
								else
									TB = R[Rj1];
							end
						SWAP_IC:
							begin
								if (Ri1 == Ri2) TB = TALUH;
								else if (Ri2 == Rj2) TB = TALUL;
								else
									TA = R[Ri1];
								if (Rj1 == Rj2) TB = TALUL;
								else
									TB = R[Rj1];
							end
						LD_IC, ST_IC:
							begin
								MAB = PM_out;
								PgCnt = PgCnt + 1'b1;
								if (Rj1 == 0)
									MAX = 0;
								else if (Ri1 == Ri2 && IR2[13:10] != 4'b1111)
									MAX = TALUH;
								else 
									MAX = R[Ri1];
							end
						JMP_IC:
							begin
								MAB = PM_out;
								PgCnt = PgCnt + 1'b1;
								if (Ri1 == 0)
									MAX = 0;
								else if (Ri1 == Ri2)
									MAX = TALUH;
								else 
									MAX = Ri1;
							end
						default: // ADD_IC,SUB_IC, OR_IC, AND_IC, ADDV_IC
							begin
								if (Ri1 == Ri2 && IR2[13:10] != LD_IC && IR2[13:10] != ST_IC) begin TA = TALUH; end
								else begin TA = R[Ri1]; end
								if (Rj1 == Ri2) begin TB = TALUH; end
								else begin TB = R[Rj1]; end
							end
					endcase
				end
//============================================================================
		if (stall_mc2 == 0 && IR3[13:10] != JMP_IC) 
			begin IR3 = IR2; 
			Ri3 = Ri2; 
			Rj3 = Rj2; 
			stall_mc3 = 0; end 
		else begin 
			stall_mc2 =1; 
			IR3 = 14'h3fff; end
		if (stall_mc1 == 0 && IR2[13:10] != JMP_IC && IR2[13:10] != ST_IC  &&  IR2[13:10] != LD_IC ) 
			begin 
			IR2 = IR1; 
			Ri2 = Ri1; 
			Rj2 = Rj1; 
			stall_mc2 = 0;
			end 
		else begin 
			stall_mc1 = 1; IR2 = 14'h3fff; end 
		if (stall_mc0 == 0 && IR1[13:10] != JMP_IC && IR1[13:10] != ST_IC  &&  IR1[13:10] != LD_IC ) begin 
			IR1 = PM_out; 
			Ri1 = PM_out[9:5];
			Rj1 = PM_out[4:0]; 
			PgCnt = PgCnt + 1'b1; 
			stall_mc1 = 0; end 
		else begin stall_mc0 = 1; IR1 = 14'h3fff; end 
		if (IR3 == 14'h3fff) stall_mc0 = 0;
	end
endmodule
			
							