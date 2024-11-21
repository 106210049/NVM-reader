`include "controller.sv"
`include "PISO.sv"
// Code your design here
module NVM_reader(
  input wire clk,
  input wire rst_n,
  input wire read_en,
  input wire [7:0] data_in,
  input wire [7:0] address_in,
  
  output reg data_out,
  output reg [7:0] address_out
);
  
  reg load_signal, shift_signal;
  controller controller_inst(
  	.clk(clk),
    .rst_n(rst_n),
    .read_en(read_en),
    .load(load_signal),
    .shift(shift_signal)
  );
  
  
  PISO piso_inst(
    .clk(clk),
    .rst_n(rst_n),
    .load(load_signal),
    .shift(shift_signal),
    .data_in(data_in),
    .data_out(data_out)
  );
  assign address_out=address_in;
  
endmodule: NVM_reader