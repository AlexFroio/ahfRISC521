`timescale 1ps/1ps

module ahf4722_RISC521_v_tb1;
	reg	Reset_tb, Clk_tb;
	reg	[4:0] SW_in_tb;
	wire [7:0] Disp_out_tb;
	integer i;

ahf4722_RISC521_v	dut	(Reset_tb, Clk_tb, SW_in_tb, Disp_out_tb);
	
initial	begin	
//----------------------------------------------------------------------------
//	Resetn_tb, Clock_tb, SW_in_tb, Display_out_tb
//----------------------------------------------------------------------------
//-- Test Vector 1 (40ns): Reset
//----------------------------------------------------------------------------
	apply_test_vector(0, 0, 5'b00000);
//----------------------------------------------------------------------------
//-- All other test vectors
//----------------------------------------------------------------------------
	for (i=0; i<80; i=i+1)
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
