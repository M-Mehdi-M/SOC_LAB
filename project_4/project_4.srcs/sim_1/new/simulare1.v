`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/12/2021 12:01:13 AM
// Design Name: 
// Module Name: simulare
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


module simulation( );
    
    reg [15:0]a_0;
    reg [15:0]b_0;
    wire c_out_0;
    wire P_0;
    wire G_0;
    reg carry_in_0;
    wire [15:0]sum_0;

    design_1_wrapper sumator16b(G_0,
    P_0,
    a_0,
    b_0,
    c_out_0,
    carry_in_0,
    sum_0);
    
    initial begin
    carry_in_0 = 0;
    a_0 = 1200; b_0 = -200;
    #100 a_0 = 2000; b_0 = 2000;
    #100 a_0 = 30000; b_0 = -31000;
end
endmodule
