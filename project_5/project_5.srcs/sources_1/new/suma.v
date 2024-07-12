`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/24/2024 04:25:30 PM
// Design Name: 
// Module Name: suma
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

module suma (
    output reg [15:0] final_sum,
    input [15:0] input_1, input_2,
    input clock_1
);

reg sign_1, sign_2;
reg [4:0] exponent_1, exponent_2;
reg [9:0] mantissa_1, mantissa_2;
reg [15:0] result;

reg [4:0] exponent_max;
reg [10:0] mantissa_1_11, mantissa_2_11;
reg sign;
reg [11:0] sum;

reg [10:0] mantissa1_1, mantissa2_1;
reg [4:0] exponent1, exponent2, exponent3, exponent4;
reg sign1_2, sign1_1, sign2_1, sign2_2;
reg [11:0] sum_2, sum_3, sum_4;
reg sign_2, sign_3, sign_4;

integer i;

always @* begin
    sign_1 = input_1[15];
    sign_2 = input_2[15];
    exponent_1 = input_1[14:10];
    exponent_2 = input_2[14:10];
    mantissa_1 = input_1[9:0];
    mantissa_2 = input_2[9:0];
end

always @* begin
    if (exponent_1 >= exponent_2) begin
        exponent_max = exponent_1;
        mantissa_2_11 = (mantissa_2 == 10'b0000_0000_00) ? {1'b0, mantissa_2} : {1'b1, mantissa_2} >> (exponent_1 - exponent_2);
        mantissa_1_11 = (mantissa_1 == 10'b0000_0000_00) ? {1'b0, mantissa_1} : {1'b1, mantissa_1};
    end else begin
        exponent_max = exponent_2;
        mantissa_1_11 = (mantissa_1 == 10'b0000_0000_00) ? {1'b0, mantissa_1} : {1'b1, mantissa_1} >> (exponent_2 - exponent_1);
        mantissa_2_11 = (mantissa_2 == 10'b0000_0000_00) ? {1'b0, mantissa_2} : {1'b1, mantissa_2};
    end
end

always @(posedge clock_1) begin
    mantissa1_1 <= mantissa_1_11;
    mantissa2_1 <= mantissa_2_11;
    exponent1 <= exponent_max;
    sign1_1 <= sign_1;
    sign2_1 <= sign_2;
end

always @* begin
    if (sign1_1 == sign2_1) begin
        sign = sign1_1;
        sum = mantissa1_1 + mantissa2_1;
    end else begin
        if (mantissa1_1 > mantissa2_1) begin
            sign = sign1_1;
            sum = mantissa1_1 - mantissa2_1;
        end else begin
            sign = sign2_1;
            sum = mantissa2_1 - mantissa1_1;
        end
    end
end

always @(posedge clock_1) begin
    sum_2 <= sum;
    sign1_2 <= sign1_1;
    sign2_2 <= sign2_1;
    exponent2 <= exponent1;
    sign_2 <= sign;
end

always @* begin
    if (sign1_2 == sign2_2 && sum_2[11] == 1'b1) begin
        sum_2 = sum_2 >> 1;
        exponent2 = exponent2 + 1;
    end else begin
        i = 0;
        while ((i <= 11) && (sum_2[10] == 1'b0) && (sum_2 != 12'b0)) begin
            sum_2 = sum_2 << 1;
            exponent2 = exponent2 - 1;
            i = i + 1;
        end
    end
end

always @(posedge clock_1) begin
    sum_3 <= sum_2;
    exponent3 <= exponent2;
    sign_3 <= sign_2;
end

always @(posedge clock_1) begin
    sum_4 <= sum_3;
    exponent4 <= exponent3;
    sign_4 <= sign_3;
end

always @* begin
    final_sum[15] = sign_4;
    final_sum[14:10] = exponent4;
    final_sum[9:0] = sum_4[9:0];
end

endmodule

