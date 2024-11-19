module NVM_reader (
	input Read, CLK, RST,
	input [4:0] Addr,
	output DATA );
	
	wire [7:0] bus1;
	wire [3:0] Q;
	
	NVM NVM (.Addr(Addr), .D_Out(bus1));
	U4_bit_Counter counter (.En(Read), .CLK(CLK), .RST(RST), .Q(Q), .CLR(Q<9));
	PISO PISO (.Load(Q!=1), .D_In(bus1), .CLK(CLK), .RST(RST), .Read(Read), .D_Out(DATA));
	
endmodule