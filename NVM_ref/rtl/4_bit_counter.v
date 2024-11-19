module U4_bit_Counter (
	input En, CLK, RST,CLR,
	output reg [3:0] Q
);
	always @(posedge CLK) begin
		if(!RST) Q <= 0;
		else if(!CLR) Q <= 0;
		else if (En) Q <= Q + 1;
		else Q <= 0;
	end
	
endmodule