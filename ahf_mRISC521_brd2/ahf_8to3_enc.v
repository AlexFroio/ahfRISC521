module ahf_8to3_enc (x, y);

input [7:0] x;
output reg [2:0] y;

always @ (x) begin
	case(x)
		8'h02: y = 3'b0001;
		8'h04: y = 3'b0010;
		8'h08: y = 3'b0011;
		8'h10: y = 3'b0100;
		8'h20: y = 3'b0101;
		8'h40: y = 3'b0110;
		8'h80: y = 3'b0111;
		default: y = 3'b0000;
	endcase
end

endmodule
		