`timescale 1ps/1ps

module ahf_mRISC521_brd_tb;
	reg	Reset_tb, Clk_tb;
	reg	[4:0] SW_in_tb;
	wire [7:0] Disp_out_tb;
	integer i;

ahf_mRISC521_brd	dut	(
.Reset (Reset_tb),
.CLOCK_50 (Clk_tb),
.SW (SW_in_tb),
.DISP (Disp_out_tb)
);
	
initial	begin	
//----------------------------------------------------------------------------
//	Resetn_tb, Clock_tb, SW_in_tb, Display_out_tb
//----------------------------------------------------------------------------
//-- Test Vector 1 (40ns): Reset
//----------------------------------------------------------------------------
	for(i=0; i<40; i = i+1)
		apply_test_vector(0, 0, 5'b00000);
//----------------------------------------------------------------------------
//-- All other test vectors
//----------------------------------------------------------------------------
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01110);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b11100);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b01000);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b10010);
	for (i=0; i<320; i=i+1)
		apply_test_vector(1, 0, 5'b00110);
	for (i=0; i<4000; i=i+1)
		apply_test_vector(1, 0, 5'b00000);
end

task apply_test_vector;
	input	Reset_int, Clk_int;
	input	[4:0] SW_in_int;
	
	begin
		Reset_tb = Reset_int; Clk_tb = Clk_int; 
		SW_in_tb = SW_in_int;
		#20000;
		Clk_tb = 1;
		#20000;
	end
endtask
endmodule
