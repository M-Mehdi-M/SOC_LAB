`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2024 04:27:41 PM
// Design Name: 
// Module Name: suma_tb
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

module suma_tb();

reg [15:0] input_1, input_2;
reg clock;
wire [15:0] sum;

suma_ d (sum, input_1, input_2, clock);

initial begin
	clock = 0;
	forever begin
		#5 clock = ~clock;
	end
end

initial begin

	@(negedge clock); 
		input_1 = 16'b0_10101_0001000000; // 68
		input_2 = 16'b0_10100_0001000000; // 34
		                                  // 102
	@(negedge clock); 
		input_1 = 16'b1_10101_1000100000; // -98
		input_2 = 16'b0_10110_0101001000; // 169
		                                  // 71
	@(negedge clock); 
		input_1 = 16'b0_10110_1001110000; // 206
		input_2 = 16'b1_10100_1100100000; // -57
		                                  // 149
	@(negedge clock); 
		input_1 = 16'b1_10111_0001101100; // -283
		input_2 = 16'b1_10101_0000100000; // -66
		                                  // 349
	@(negedge clock); 
		input_1 = 16'b0_00000_0000000000; // 0
		input_2 = 16'b0_00000_0000000000; // 0
		                                  // 0
	@(negedge clock); 
		input_1 = 16'b0_10101_1000010100; // 97.275
		input_2 = 16'b1_10101_1110000110; // -120.375
		                                  // -23.1
	@(negedge clock); 
		input_1 = 16'b1_10101_1011100010; // -110.125
		input_2 = 16'b0_10101_0110000110; // 88.375
		                                  // -21.75
	@(negedge clock); 
		input_1 = 16'b1_10100_0110111010; // -45.8125
		input_2 = 16'b1_10100_1011110011; // -55.5937
		                                  // 101.375
  repeat (4) @(negedge clock);
	 $finish;

end

endmodule
