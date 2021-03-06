module ahf4722_RISC521_v (Reset_pin, Clk_pin, SW_pin, Disp_pin);
	input Reset_pin, Clk_pin;
	input [4:0] SW_pin; // 4 switches, 1 push button
	output [7:0] Disp_pin; //8 LEDs
//-----------------------------------------------------
//-- Declare Machine Cycles + instr. cycle parameters
//-----------------------------------------------------
	parameter [3:0] LD_IC=4'b0000, ST_IC=4'b0001, CPY_IC=4'b0010, SWAP_IC=4'b0011, 
		JMP_IC=4'b0100, ADD_IC=4'b0101, SUB_IC=4'b0110, ADDC_IC=4'b0111, 
		SUBC_IC =4'b1000, NOT_IC=4'b1001, AND_IC=4'b1010, OR_IC=4'b1011, 
		SHRA_IC=4'b1100, ROTR_IC=4'b1101;
	parameter [3:0] JU=4'b0000, JC1=4'b1000, JN1=4'b0100, JV1=4'b0010, 
		JZ1=4'b0001, JC0=4'b0111, JN0=4'b1011, JV0=4'b1101, JZ0=4'b1110;
//----------------------------------------------------------------------------
//-- Declare internal signals
//-- Specs: 14-bit words, 8-bit SR, 32 gen.-purpose Registers, 1 Phys address mode
//-- Memory range 0x3F00 to 0x3FFF
//----------------------------------------------------------------------------
	reg [13:0] R [31:0];
	reg [4:0] ROTreg;
	reg  WR_DM, stall_mc0, stall_mc1, stall_mc2, stall_mc3;
	reg [1:0] MC;
	reg [13:0] PgCnt, IR3, IR2, IR1, MAB, MAX, MAeff, SP, DM_in, IPDR;
	reg [13:0] TA, TB, TALUH, TALUL;
	reg [7:0] TSR, SR;
	reg [7:0] Disp_pin;
	reg [14:0] TALUout;
	wire [13:0] PM_out, DM_out;
	wire 			C, Clk_not;
	integer Ri1, Rj1, Ri2, Rj2, Ri3, Rj3, i;
	
	assign Clk_not = ~Clk_pin;
// Instantiated 1k word memories to save resources:
	ahfRISC521_rom1 my_rom (PgCnt[9:0], Clk_not, PM_out);
	ahfRISC521_ram1 my_ram (MAeff[9:0], Clk_not, DM_in, WR_DM, DM_out);
	
	always@(posedge Clk_pin)
	
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
			end
		else begin
//============================================================================
// 		Below is MC3, it executes first in case MC2 needs any data from it
//============================================================================
			if (stall_mc3 == 0) 
				begin 
					case (IR3[13:10])
						LD_IC:
							begin
								if (MAeff[13:8] == 6'h3F)
									if (MAeff[3:0] == 4'hF)
										R[IR3[4:0]] = SP;
									else
										R[IR3[4:0]] = {9'b000000000, SW_pin[4:0]};
								else
									R[IR3[4:0]] = DM_out;
							end
						ST_IC:
							begin
								WR_DM = 1'B0;
								if (MAeff[13:8] == 6'h3F)
									if (MAeff[3:0] == 4'hF)
										SP = R[IR3[4:0]];
									else
										Disp_pin = R[IR3[4:0]][7:0];
								else ;
							end
						CPY_IC:
							begin
								R[IR3[4:0]] = TALUL;
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
											PgCnt = PgCnt + MAeff; //Intentional to make forward and backwards jumps easier
										end
									JC1:
										begin
											if (SR[7] == 1)
											PgCnt = PgCnt + MAeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JC0:
										begin
											if (SR[7] == 0)
											PgCnt = PgCnt + MAeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JN1:
										begin
											if (SR[6] == 1)
											PgCnt = PgCnt + MAeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JN0:
										begin
											if (SR[6] == 0)
											PgCnt = PgCnt + MAeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JV1:
										begin
											if (SR[5] == 1)
											PgCnt = PgCnt + MAeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JV0:
										begin
											if (SR[5] == 0)
											PgCnt = PgCnt + MAeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JZ1:
										begin
											if (SR[4] == 1)
											PgCnt = PgCnt + MAeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
									JZ0:
										begin
											if (SR[4] == 0)
											PgCnt = PgCnt + MAeff;//Intentional to make forward and backwards jumps easier
											else
											PgCnt = PgCnt;
										end
								endcase
							end
						ADD_IC, ADDC_IC, SUB_IC, SUBC_IC, NOT_IC, AND_IC, OR_IC, SHRA_IC, ROTR_IC:
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
						LD_IC, JMP_IC:
							begin
								MAeff = MAB + MAX;
								WR_DM = 1'b0;
							end
						ST_IC:
							begin
								MAeff = MAB + MAX;
								if (MAeff[13:8] == 6'h3F) begin
									WR_DM = 1'b1; 
									if (Rj2 == Ri3 && IR3[13:10] != (LD_IC || ST_IC || JMP_IC)) 
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
								if (Ri1 == Ri2) begin TA = TALUH; end
								else begin
									TA = R[Ri1];
									TB = {14'h0000, IR1[4:0]};
								end
							end
						NOT_IC, SHRA_IC, ROTR_IC:
							begin
								if (Ri1 == Ri2) begin
									TA = TALUH;
									end
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
							else
								TA = R[Ri1];
							if (Rj1 == Rj2) TB = TALUL;
							else
								TB = R[Rj1];
							end
						LD_IC, ST_IC, JMP_IC:
							begin
								MAB = PM_out;
								PgCnt = PgCnt + 1;
								if (Ri1 == 0)
									MAX = 0;
								else if (Ri1 == Ri2)
									MAX = TALUH;
								else 
									MAX = Ri1;
							end
						default: // ADD_IC,SUB_IC, OR_IC, AND_IC
							begin
								if (Ri1 == Ri2) begin TA = TALUH; end
								else begin TA = R[Ri1]; end
								if (Rj1 == Rj2) begin TB = TALUH; end
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
	if (stall_mc1 == 0 && IR2[13:10] != JMP_IC) 
		begin IR2 = IR1; 
		Ri2 = Ri1; 
		Rj2 = Rj1; 
		stall_mc2 = 0;
		if (IR2[13:10] == (LD_IC || ST_IC)) stall_mc0 = 0;
		end 
	else begin 
		stall_mc1 = 1; IR2 = 14'h3fff; end 
	if (stall_mc0 == 0 && IR1[13:10] != JMP_IC) begin 
		IR1 = PM_out; 
		 Ri1 = PM_out[9:5];
		Rj1 = PM_out[4:0]; 
		PgCnt = PgCnt + 1'b1; 
		stall_mc1 = 0; end 
	else begin stall_mc0 = 1; IR1 = 14'h3fff; end 
	if (IR3 == 14'h3fff) stall_mc0 = 0;
	end
endmodule
			
							