`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 11:35:03 AM
// Design Name: 
// Module Name: test_numarator
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_numarator();
        reg clk_out_loud, reset, pauza;
        wire [5:0]valoare_bin;
        wire carry_out;
  BinaryCounter num(clk_out_loud, reset, pauza,valoare_bin, carry_out);
  always #5 clk_out_loud=~clk_out_loud;
  initial begin
  reset=1;
  pauza=0;
  clk_out_loud=1;
  #10;
  reset=0;
  #50
  pauza=1;
  #50 
  pauza=0;
  end
  
endmodule
