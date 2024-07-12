`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 10:56:48 AM
// Design Name: 
// Module Name: numarator
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


module BinaryCounter(
    input clk_out_led,
    input reset,
    input pauza,
    output reg [5:0] valoare_bin,
    output reg carry_out
    );


reg [5:0] count;

always @(posedge clk_out_led or posedge reset) begin
    if (reset) begin
        count <= 6'b0;
        carry_out <= 0;
    end else if (pauza) begin
    
    end else begin
        count <= count + 1;
        if (count == 6'b111011) begin
            carry_out <= 1;
            count <=6'b0;
        end else begin
            carry_out <= 0;
        end 
    end 
end

always @* begin
    valoare_bin = count;
end

endmodule
