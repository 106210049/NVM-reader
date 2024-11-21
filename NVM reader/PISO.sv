module PISO(
  input wire clk,
  input wire rst_n,
  input wire load,
  input wire shift,
  input wire [7:0] data_in,
  
  output reg data_out
);
 reg [7:0] shift_reg;
  always@(posedge clk or negedge rst_n)	begin
    
    if(!rst_n)	begin
      data_out<=0;
      shift_reg<=8'd0;
    end
    else	begin
        if(load)	begin
        	shift_reg<= data_in;
      	end
      	else if(shift)	begin 
          data_out <= shift_reg[7];            // Output MSB as serial output
          shift_reg <= {shift_reg[6:0],1'b0};   // Shift left
      	end
        else begin
          data_out<=0;
        end
   	 end
 end 
endmodule: PISO