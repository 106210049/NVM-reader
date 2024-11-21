`include "FSM.sv"
`include "counter.sv"
module controller(
  input wire clk,
  input wire rst_n,
  input wire read_en,
  
  output reg load,
  output reg shift
);
  reg finish_signal, shift_signal;
  FSM fsm_inst(
    .clk(clk),
    .rst_n(rst_n),
    .read_en(read_en),
    
    .finish(finish_signal),
    .load(load),
    .shift(shift_signal)
  );
  
  Counter counter_inst(
  	.clk(clk),
    .rst_n(rst_n),
    .en(shift_signal),
    .finish(finish_signal)
  );
  assign shift=shift_signal;
endmodule: controller