module NVM_FSMD	(output Data_out,
								output [4:0] Address_out,
								input read, clk, clr,
								input [4:0] Address_in,
								input [7:0] Data_in);
								
parameter S_idle 			= 2'b01,
					S_ShiftDec 	= 2'b10;
reg [1:0]state, next_state;
reg shift_dec, load, clear, empty;
reg [2:0] count;
reg [7:0] PISO;

//--- control path

always@ (posedge clk, negedge clr)
	if (clr == 0)
		state <= S_idle;
	else
		state <= next_state;

		//--- next_state and output logic
always@(state, read, empty)
begin
//initial value
shift_dec = 0;
load = 0;
clear = 0;

	case (state)
	S_idle: 			begin
									//clear = 1;
									if (read == 1) begin
										load = 1;
										next_state = S_ShiftDec;
									end
									else begin
										clear = 1;
										next_state = S_idle;
									end
								end
		
	S_ShiftDec:		begin
									//shift_dec = 1;
									if (read == 1)
										if (empty == 0) begin
											shift_dec = 1;
											next_state = S_ShiftDec;
										end
										else begin
											next_state = S_ShiftDec;
											load = 1;
										end
									else
										next_state = S_idle;
								end		
	endcase						
end

// data path
always@ (posedge clk) 
begin
	if (clear == 1) begin
		PISO <= 0;
		count <= 0;
	end	

	if (load == 1) begin
		PISO <= Data_in;
		count <= 0;
	end

	if (shift_dec == 1) begin
		PISO <= {PISO[6:0],1'b0};
		count <= count + 1;
	end
	
end

always@ (count)
if (count == 3'd7)
		empty = 1;
	else
		empty = 0;

assign	Data_out = PISO[7],
				Address_out = Address_in;

endmodule


	