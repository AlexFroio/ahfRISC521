module ahf_CAM_v (WE_n, RD_n, Din, Argin, Addrs, Dout, Mbits);

// Declare I/Os
input WE_n, RD_n;
input [9:0] Din, Argin;
input [2:0] Addrs; 
output reg [9:0] Dout; 
output reg [7:0]Mbits;

// Declare internal memory array
reg	[9:0] cam_mem [7:0];
integer i, int_addrs;

// Write procedural block
// enables a new tag value to be written at a specific location,
// using the WRITE ENABLE, data input and address input busses as with any other memory
// This happened whenever a new block is uploaded to the cache
always @ (WE_n, Din, Addrs)
	begin	
		int_addrs = Addrs;
		if (WE_n == 0)
			begin
				cam_mem[int_addrs] = Din;
			end
	end
// Read procedural block.
// This allows a value at a specific locatio to be read out,
// Using a RD, data output and address input busses as with any other memory
//For a cache, this is unnecessary. It's provided for reference and debugging purposes
always @ (RD_n, Addrs, cam_mem)
	begin
		int_addrs = Addrs;
		if (RD_n == 0)
			begin
				Dout = cam_mem[int_addrs]; 
			end
		else
			begin
				Dout = 10'bzzzzzzzzzz;
			end
	end
// Match procedural block.
// Implements the actual CAM function
// An Mbit is 1 if the argument value == content of the memory location
//	associated w/ it.
always @ (Argin, cam_mem)
	begin
		Mbits = 8'h00;
			for (i = 0; i <=7; i=i+1)
				begin
					if(Argin == cam_mem[i])
						begin
							Mbits[i]=1;
						end
				end
	end
endmodule
