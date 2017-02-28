module ahf_2to1Mux_v (Sel, Din0, Din1, Mux_out);

input [13:0] Din0, Din1;
input Sel;
output reg [13:0] Mux_out;

always @(Sel or Din0 or Din1)
begin
	case(Sel)
		1'b0: Mux_out = Din0;
		1'b1: Mux_out = Din1;
	endcase
end
endmodule
