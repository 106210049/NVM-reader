`timescale 1ns / 10ps

module NVM_reader_tb;

	parameter T=10;
	parameter END_TIME = 20*T;

	reg Read, CLK, RST;
	reg [4:0] Addr;
	wire DATA;
	//internal variables
	reg [7:0] test_value[31:0];
	integer i,j, current_Addr;
	
	NVM_reader dut (
		.Read(Read),
		.CLK(CLK),
		.RST(RST),
		.Addr(Addr),
		.DATA(DATA)
	  );
	  
	always #(T/2) CLK = ~CLK;
	  
	initial begin
		CLK = 1;
		RST = 0;
		Read = 0;
		Addr = 5'b00000;
		
		#T RST = 1;
		
		#T;
		Read = 1;
		Addr = 5'b00001;
		#(4*T);
		Addr = 5'b00010;
		Read = 0;
		#(1*T);
		Read = 1;
		Addr = 5'b00011;
		#(4*T);
		
	  end
		
		//END SIMULATION
		initial begin
		repeat (END_TIME) begin
		@ (posedge CLK);
		end
		$display ("[%t]--------------- SIMULATION PASS ---------------", $time);
		$stop;
		end
		//set Test value
		initial begin
		for (i = 0; i < 32; i=i+1) begin
			test_value[i] = i*2;
		end
		end
		
		always @ (posedge CLK) begin
		if (!RST || !Read) j <= 0;
		else if (j == 11) j <= 2;
		else j <= j + 1;
		end
		
		always @ (*) if(j==1 || j==11) current_Addr <= Addr;
		
		//Check reset
		always @ (*) begin
			if (!RST && DATA != 1'b1) begin
			$display ("--------------- SIMULATION FAIL ---------------");
			$display ("[%t]The reset value of DUT: %b\tThe DATA : %b", $time,RST, DATA);
			$stop;
			end
		end
		//Check the output of data when read
		always @ (*) begin
		if(RST && Read ) begin
			//Check startBit
			if(j==2 && DATA != 0)begin
			$display ("--------------- SIMULATION FAIL ---------------");
			$display ("[%t]The j value of DUT: %b\tThe DATA : %b", $time,j, DATA);
			$stop;
			end
			//Check endBit
			if(j==11 && DATA != 1)begin
			$display ("--------------- SIMULATION FAIL ---------------");
			$display ("[%t]The j value of DUT: %b\tThe DATA : %b", $time,j, DATA);
			$stop;
			end  
			//Check data
			if( (j>2 && j<11) && DATA != test_value[current_Addr][j-3])begin
			$display ("--------------- SIMULATION FAIL ---------------");
			$display ("[%t]The DATA value of DUT: %b\tThe test value : %b", $time,DATA, test_value[current_Addr][j-3]);
			$stop;
			end 
		//Check when when not read
		if(!Read && DATA != 1)begin
			$display ("--------------- SIMULATION FAIL ---------------");
			$display ("[%t]The RST value of DUT: %b\tThe DATA : %b\tThe Read value:", $time,RST, DATA, Read);
			$stop;
		end 
		end
	end
	endmodule
