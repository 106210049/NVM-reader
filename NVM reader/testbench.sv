// Code your testbench here
// or browse Examples
`timescale 1ns/1ps

module NVM_reader_tb;

  // Inputs
  reg clk;
  reg rst_n;
  reg read_en;
  reg [7:0] data_in;
  reg [7:0] address_in;

  // Outputs
  wire data_out;
  wire [7:0] address_out;

  // Instantiate the NVM_reader module
  NVM_reader uut (
    .clk(clk),
    .rst_n(rst_n),
    .read_en(read_en),
    .data_in(data_in),
    .address_in(address_in),
    .data_out(data_out),
    .address_out(address_out)
  );

  // Clock generation
  always #5 clk = ~clk; // 10ns clock period (50MHz)

  // Test sequence
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    // Initialize inputs
    clk = 0;
    rst_n = 0;
    read_en = 0;
    data_in = 8'b0;
    address_in = 8'b0;

    // Apply reset
    $display("Applying reset...");
    #10 rst_n = 1;

    // Test case 1: Read enable and load data
    $display("Test case 1: Load and shift data...");
    #10 read_en = 1;
        data_in = 8'b10101010;
        address_in = 8'b11001100;
    #20 read_en = 0;

    // Test case 2: Verify data shifting
    $display("Test case 2: Shifting data...");
    #30 read_en = 1;
    #40 read_en = 0;

//     // Test case 3: Reset and verify outputs
//     $display("Test case 3: Reset module...");
//     #50 rst_n = 0;
//     #10 rst_n = 1;

    // Finish simulation
    #100 $finish;
  end

  // Monitor the output signals
  initial begin
    $monitor("Time=%0t | clk=%b rst_n=%b read_en=%b data_in=%b address_in=%b | data_out=%b address_out=%b",
              $time, clk, rst_n, read_en, data_in, address_in, data_out, address_out);
  end

endmodule
