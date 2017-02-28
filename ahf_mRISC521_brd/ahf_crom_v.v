module ahf_crom_v #(parameter mif_file)( PM_address, Clk0, Clk1, Clk2, DM_in, wren_in, Resetn, stall, PM_out);

// I/Os for the module
input [13:0]PM_address, DM_in;
input Resetn, Clk0, Clk1, Clk2, wren_in;
output [13:0] PM_out;
output reg stall;

//Structural Nets
wire [7:0] mbits; 
wire [13:0] PMM_out, mux_out; // grp -> group address?
wire [2:0] blck;
wire [9:0] dout;
//register nets
reg we_n, rd_n;
reg miss, wren;
//reg [13:0] replace = 14'h0000;

//PMC_address = cache memory address

reg [6:0] PMC_address; // should this be wide by 8x16? (8 blocks, 16 words per block)

//PMM_address is the PM memory address, would be 16-bit wide if
// our memory wasn't only 1kwords. here it is only 10-bit wide

reg [9:0] PMM_address; //
reg [13:0] cache_insert;
reg [9:0] din;
reg [2:0] cam_addrs; // pretty sure these are my data addresses
reg [2:0] blockReplace; // Keeps track of which is the next block to replace when a miss is read
reg [4:0] transfer_count;
//i is used to capture the group address field for PM and DM

integer i;

//10-bit tag?
//4-bit word address
// structure generates memory subsystem data path
// PLL generates 3 clock phases to sequence all events

//ahf_pll_3_v my_pll (Clk, c0, c1, c2); deprecated

//single CAM for fully associative tag identification
ahf_CAM_v 			my_cam 			(we_n, rd_n, din, PM_address[13:4], cam_addrs, dout, mbits);

//PM ROM, so the cache can grab the IWs
ahf_rom1 #(.mif_file(mif_file)) 	my_rom 			(PMM_address[9:0], Clk1, PMM_out);

//DM RAM, so the cache can grab memory elements
//ahfRISC521_ram1 	my_ram 			(PMM_address[9:0], c1, PM_out, PM_wren, PMM_out); 

// 2 to 1 mux, helps enable writing to cache
ahf_2to1Mux_v		my_mux			(wren_in, PMM_out, cache_insert, mux_out);

//Actual cache memory, implemented as RAM, uses c2 phase of the clock
ahf_cache_v 		my_rom_cache 	(PMC_address, Clk2, mux_out, wren, PM_out);

//ahf_cache_v 		my_ram_cache 	(DMC_address, c2, DMM_out, wren, DM_out);

// 4-16 dec identifies group being accessed

ahf_8to3_enc 		my_enc			(mbits, blck);

// is the decoder even necessary? it's fully associative.

//Behavioral code, CU of the memory subsystem
always @ (posedge Clk0) begin
	if (Resetn == 0) begin
// Initialize memory subsystem; after a reset the cache content is random
// thus miss must be set to 1; this in turn will trigger the transfer of 
// the first block from PM into the cache.
		miss = 1'b1; transfer_count = 4'h0;
		stall = 1'b1;
		we_n = 1;
//		PM_wren = 0;
//		dirtyBitCheck = 8'h00;
		blockReplace = 3'b101;
		rd_n = 0;
		cache_insert = PMM_out;
		end
	else begin
		stall = miss;
		// Fully Associative has no groups. It's structured |	 Tag 	|Data|
		// Read Hit:
		if (miss == 0) begin
			we_n = 1;
			if (mbits) begin
				PMC_address = {blck, PM_address[3:0]};
			end
			else begin
			miss = 1; transfer_count = 5'h00; 
			rd_n = 0;
			end
//			if (wren_in == 1) begin
//				wren = 1;
//				cache_insert = DM_in;
//				dirtyBitCheck[blck] = 1'b1;
//			end
		end
		if (miss == 1) begin
//			if (dirtyBitCheck[blockReplace] == 1'b1) begin
//				PM_wren = 1; wren = 1'b0; 
//				cam_addrs = blockReplace;
//				PMC_address = {blockReplace, transfer_count[3:0]};
//				PMM_address = {dout[5:0], transfer_count[3:0]};
//				transfer_count = transfer_count + 1'b1;
//				if (transfer_count == 5'h11) begin
//					PM_wren = 0; wren = 1; transfer_count = 5'h00; dirtyBitCheck[blockReplace] = 1'b0;
//				end
//			end
//			else begin
				PMC_address = {blockReplace , transfer_count[3:0]};
				PMM_address = {PM_address[9:4], transfer_count[3:0]};
				cache_insert = PMM_out;
				wren = 1'b1;
				transfer_count = transfer_count + 1'b1;
//			end

			
				
		end
		if (transfer_count == 5'h11) begin
			miss = 0;
//			PM_wren = 0;
			wren = 0;
			cam_addrs = blockReplace;
			blockReplace = blockReplace + 1'b1;
			transfer_count = 5'h00;
			din = PM_address[13:4];
			we_n = 0;
		end
		
	end
end
endmodule
				
			
			