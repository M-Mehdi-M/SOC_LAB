`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 09:05:38 AM
// Design Name: 
// Module Name: test
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

module testModule();
    reg clear;
	reg load;
	reg clk;
	
	reg [31:0] A;
	reg [31:0] B;
	
	wire [31:0] C;
    reg op;

    initial begin
        clk = 0;
        forever begin
            #5 clk = ~clk;
        end
    end
    
	Suma sum(clear, load, clk,op , A, B, C);
        
	initial begin
		clear = 0;
		load = 0;
		clk = 0;
		
		#20
		load = 1;
		
		op = 0;
		A = 32'b01000000000000000000000000000111;
		B = 32'b01000000000000000000000000000011;   // 7  +  3 = 10
		
		#20
		op = 0;
		A = 32'b01000000000000000000000000000110; 
		B = 32'b01000000100000000000000000000011;   //12 + 12 = 24
		
		#20
		op = 1;
		A = 32'b01000000000000000000000000000111;
		B = 32'b01000000000000000000000000001100;  //7 - 12 = -5
		
		#20
		op = 1;
		A = 32'b01000000000000000000000000000011;
		B = 32'b00111111100000000000000000000001;  //3 - 0.5 = 3
		
		#20
	    op = 0;
		A = 32'b10111111011001100110011001100110; // -0.9
		B = 32'b10111101110011001100110011001101; // -0.1
				
	end
	
endmodule
