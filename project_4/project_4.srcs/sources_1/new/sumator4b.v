`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2023 14:53:00 PM
// Design Name: 
// Module Name: UAL
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


module sumator4b(a, b, carry_in, c_out, sum, G, P);
    input [3:0] a, b;
    input carry_in;
    output [3:0] sum;
    output G, P, c_out;
    wire [3:0] p, g, c;
    
    assign p = a ^ b;
    assign g = a & b;
    assign c[0] = carry_in;
    
    uat uat_instc (
        .c0(carry_in),
        .p0(p[0]),
        .g0(g[0]),
        .c1(c[1]),
        .p1(p[1]),
        .g1(g[1]),
        .c2(c[2]),
        .p2(p[2]),
        .g2(g[2]),
        .c3(c[3]),
        .p3(p[3]),
        .g3(g[3]),
        .c4(c_out),
        .P(P),
        .G(G)
    );

    assign sum = p ^ c;
endmodule
