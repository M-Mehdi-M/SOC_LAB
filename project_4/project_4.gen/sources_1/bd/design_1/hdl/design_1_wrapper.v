//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.1 (win64) Build 3865809 Sun May  7 15:05:29 MDT 2023
//Date        : Wed Apr  3 10:52:23 2024
//Host        : DESKTOP-K67LBEE running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (G_0,
    P_0,
    a_0,
    b_0,
    c_out_0,
    carry_in_0,
    sum_0);
  output G_0;
  output P_0;
  input [15:0]a_0;
  input [15:0]b_0;
  output c_out_0;
  input carry_in_0;
  output [15:0]sum_0;

  wire G_0;
  wire P_0;
  wire [15:0]a_0;
  wire [15:0]b_0;
  wire c_out_0;
  wire carry_in_0;
  wire [15:0]sum_0;

  design_1 design_1_i
       (.G_0(G_0),
        .P_0(P_0),
        .a_0(a_0),
        .b_0(b_0),
        .c_out_0(c_out_0),
        .carry_in_0(carry_in_0),
        .sum_0(sum_0));
endmodule
