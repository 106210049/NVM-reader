
module PISO (
	input [7:0] D_In,
	input CLK, RST, Load, Read,
	output D_Out
);

	reg [8:0] temp = 9'b1;
	
	always @(posedge CLK)
	begin 
		if(!RST || !Read )
			temp <= 9'b111111111;
		else 
			case (Load)
			0: 	begin 
				temp[8:1] <= D_In; 
				temp[0] <= 0;
				end
				
			default: begin
					temp <= temp >> 1;
					temp[8] <= 1;
					end
			endcase		
	end
	
	assign D_Out = temp[0];
endmodule
			
		