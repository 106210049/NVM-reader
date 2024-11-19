`timescale 1ns/1ns
module U4_bit_Counter_tb;
	//parameter
	parameter END_TIME = 200;
	parameter VALUE_NUM = 16;

	//Interface of DUT
	reg En, CLK, RST;
	wire [3:0] Q;
	reg CLR;
	
	//internal variables
	reg [3:0] test_value[VALUE_NUM-1:0];
	integer i,j;
	
	//DUT instance
	U4_bit_Counter dut (
		.En(En),
		.CLK(CLK),
		.RST(RST),
		.Q(Q),
		.CLR(CLR)
	
	);
	
	//Generate clock
	always #5 CLK = ~CLK;
	
	//Generate stimulus
	initial begin
		CLK = 0;
		RST = 0;
		En = 0;
		CLR = 0;
		#10 RST = 1;
			CLR = 1;
		#10 En = 1;
		#50 RST = 0;
		#10 RST = 1;
		#90 CLR = 0;
		#10 CLR = 1;
	end
	
	
	//END SIMULATION
	initial begin
	repeat (END_TIME) begin
	@ (posedge CLK);
	end
	$display ("[%t]--------------- SIMULATION PASS ---------------", $time);
	$stop;
	end
	
	//Monitor
	initial begin
	j = VALUE_NUM;
	test_value[0] = 0;
	for (i = 1; i < VALUE_NUM; i=i+1) begin
		test_value[i] = i;
	end
	end

	
	always @ (posedge CLK) begin
		if (~RST || ~En || ~CLR) j <= 0;
		else if (j == VALUE_NUM-1) j <= 0;
		else j <= j + 1;
	end
	//Check reset, clear
	always @ (*) begin
		if ((!RST || !CLR) && (j != VALUE_NUM) && (Q != test_value[j])) begin
		$display ("--------------- SIMULATION FAIL ---------------");
		$display ("[%t]The reset value of DUT: %b\tThe TEST value: %b", $time, Q, test_value[j]);
		$stop;
		end
	end
	//Check the output of the  counter
	always @ (posedge CLK) begin
	  if (RST && (Q != test_value[j])) begin
		$display ("--------------- SIMULATION FAIL ---------------");
	 	$display ("[%t]The DUT value: %b\tThe TEST value: %b j: %b", $time, Q, test_value[j], j);
	  	$stop;
	end
	end

endmodule

