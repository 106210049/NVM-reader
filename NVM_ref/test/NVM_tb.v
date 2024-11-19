`timescale 1ns / 1ps

module NVM_tb;

    
    reg [4:0] Addr;
    wire [7:0] D_Out;

    NVM DUT (
        .Addr(Addr),
        .D_Out(D_Out)
    );
	
	integer i;
    initial begin
        for(i =0; i<32;i=i+1) begin	
		Addr = i;
		#5;
		end
    end

    

endmodule


