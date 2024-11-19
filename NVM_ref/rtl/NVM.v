module NVM (
    input [4:0] Addr,
    output reg [7:0] D_Out
);

    reg [7:0] NVM [31:0];
	integer i;
	initial begin
		for (i=0; i<=31; i=i+1) 	
			NVM[i] = i*2;	
	end
	
    always @(*) begin
      D_Out = NVM[Addr];
	end
   
endmodule

