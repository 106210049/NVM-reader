
`timescale 1ns / 10ps

module PISO_tb;

	localparam T=10;
	parameter END_TIME = 20*T;

	reg [7:0] D_In;
	reg CLK, RST, Read, Load;
	wire D_Out;
    PISO DUT (
        .D_In(D_In),
        .D_Out(D_Out),
		.CLK(CLK),
		.Read(Read),
		.RST(RST),
		.Load(Load)
    );
	//Generate clock
	always 
	begin 
		CLK = 1'b1;
		# (T/2);
		CLK = 1'b0;
		# (T/2);
	end
	//Generate Reset
	initial
	begin
		RST = 1'b0;
		# (2*T);
		RST = 1'b1;
	end
	//Generate stimulus
    initial begin
		D_In = 2;
		Load = 1;
		Read = 1;
		#(5*T);
		
		Load = 0;
		D_In = 4;
		# (1*T);
		Load =1;
		Read = 1;
		D_In = 6;
				
    end
	//END SIMULATION
	initial begin
	repeat (END_TIME) begin
	@ (posedge CLK);
	end
	$display ("[%t]--------------- SIMULATION PASS ---------------", $time);
	$stop;
	end
    

endmodule


