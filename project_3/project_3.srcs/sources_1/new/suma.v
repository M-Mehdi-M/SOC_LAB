`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/17/2024 09:04:08 AM
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


module Init(A, B, exponenti, mantise);
    input [31:0] A, B;
    output reg [15:0] exponenti;
    output reg [47:0] mantise;
    
    always @ (*)
        begin
            
            exponenti[15:8] = A[30:23];
            exponenti[7:0] = B[30:23];
            
            mantise[47] = A[31];
            mantise[46:24] = A[22:0];
            mantise[23] = B[31];
            mantise[22:0] = B[22:0];
        end   
endmodule

module Concatenare(mantise, diferenta, mantise2);
    input wire [47:0] mantise;
    input wire [8:0] diferenta;
    output reg [56:0] mantise2;
    
    always @ (diferenta)
        begin
            mantise2[56:48] = diferenta[8:0];
            mantise2[47:0] = mantise[47:0];
        end
endmodule

module ComparaExponenti(exponenti, diferenta);
    input wire [15:0] exponenti;
    output reg [8:0] diferenta;
    
    reg [7:0] exp1, exp2;
    
    always @ (exponenti)
        begin
            exp1 = exponenti[15:8];
            exp2 = exponenti[7:0];
            
            if(exp1 > exp2)
                begin
                    diferenta[8] = 1;
                    diferenta[7:0] = exp1 - exp2;
                    
                end
            else
                begin
                    diferenta[8] = 0;
                    diferenta[7:0] = exp2 - exp1;
                    
                end
        end
endmodule

module AlegeExponent(exponenti, exponent);
    input wire [15:0] exponenti;
    output reg [7:0] exponent;
    
    reg [7:0]exp1, exp2;
    always @ (exponenti)
        begin
            exp1 = exponenti[15:8];
            exp2 = exponenti[7:0];
            if(exp1 > exp2)
                begin
                    exponent[7:0] = exponenti[15:8];
                end
            else
                begin
                    exponent[7:0] = exponenti[7:0];
                end
        end
endmodule

module AliniereMantise(mantise, mantise_out);
    input wire [56:0] mantise;
    output reg [47:0] mantise_out;
   
    reg [8:0] diferenta;
	reg [23:0] mantisa1, mantisa2;
    reg sign;
    
    always @ (mantise)
        begin
            diferenta = mantise[56:48];
            mantisa1 = mantise[47:24];
			mantisa2 = mantise[23:0];
			
			if (diferenta[8] == 1'b1) //exp1 >
				begin
				    sign = mantisa2[23];
					mantisa2 = mantisa2 >> diferenta[7:0];
					mantisa2[23] = sign;
					
				end
			else
				begin
				    sign = mantisa1[23];
					mantisa1 = mantisa1 >> diferenta[7:0];
					mantisa1[23] = sign;
				end
		     mantise_out[47:24] = mantisa1[23:0];
	         mantise_out[23:0] = mantisa2[23:0];
        end
    
endmodule

module AdunaScadeMantisele(mantise, mantisa_out, op);
    input wire [47:0] mantise;
    input wire op;
    
    
    output reg [25:0] mantisa_out;
    
    reg [22:0] mantisa1, mantisa2;
    
    always @ (mantise)
        begin

            mantisa1 = mantise[46:24];
            mantisa2 = mantise[22:0];
            
            mantisa_out[25] = 0;
            if((mantise[47] == mantise[23]) ^ op)
			     begin 
			         mantisa_out[23:0] = mantisa1 + mantisa2;
			         mantisa_out[24] = mantise[47];
			     end 
			 else 
			     begin 
			         if(mantisa1 > mantisa2)
			             begin 
			                 mantisa_out[22:0] = mantisa1 - mantisa2;
			                 mantisa_out[24] = mantise[47];
			             end 
			         else
			             begin
			                 mantisa_out[22:0] = mantisa2 - mantisa1;
			                 mantisa_out[24] = mantise[23] ^ op;
			             end  
			             
			          mantisa_out[23] = 0;
			          mantisa_out[25] = (mantisa1 == mantisa2);
			     end
			 
        end
    
endmodule

module Normalizare (mantisa, diferenta_norm, mantisa_out);
	
	input wire [25:0] mantisa;
	output reg [4:0] diferenta_norm;
	output reg [23:0] mantisa_out;
	
	reg [23:0] m;
	
    always @ (mantisa)
        begin
            
            m = mantisa[23:0];
            
            diferenta_norm = 1'b1;
            
            if(m[23] == 1)
                begin
                    m = m >> 1'b1;
                    diferenta_norm = 0;
                end
                
            if(mantisa[25] != 1)
                begin
                    while(m[22] == 0)
                    begin
                        m = m << 1'b1;
                        diferenta_norm = diferenta_norm + 1'b1;
                    end
                
                end
             mantisa_out[22:0] = m[22:0];
             mantisa_out[23] = mantisa[24];
            
            
        end
		
endmodule

module AjustareExponent (exponent, diferenta_norm, exponent_out);
	
	input wire [7:0] exponent;
	input wire [4:0] diferenta_norm;
	output reg [7:0] exponent_out;
	
	reg [4:0] diferenta;
	
	
    always @ (exponent | diferenta_norm)
        begin
            
            diferenta[4:0] = diferenta_norm[4:0];
            if (diferenta == 0)
                begin
                    exponent_out[7:0] = exponent + 1'b1;		
                end
            else
                begin
                    exponent_out = exponent - (diferenta - 1'b1);
                end
        end
endmodule

module Mantisele(clear, load, clk, mantise, mantise_out);
    input clear, load, clk;
    input wire [47:0] mantise;
    output reg [47:0] mantise_out;
    always @(posedge clk)
        begin
            if(clear)
                mantise_out <= 0;
            else
                if(load)
                    mantise_out <= mantise;
       end
endmodule

module Exponentii(clear, load, clk, exponent, exponent_out);
    input clear, load, clk;
    input wire [15:0] exponent;
    output reg [15:0] exponent_out;
    always @(posedge clk)
        begin
            if(clear)
                exponent_out <= 0;
            else
                if(load)
                    exponent_out <= exponent;
       end
endmodule

module Suma(clear, load, clk,op , A, B, C);
    input clear, load, clk;
    input wire [31:0] A,B;
    input wire op;
    output wire [31:0] C;
    
    
    wire [47:0] mantisele2;
    wire [15:0] exponentii2;
    
    wire [47:0] mantisele;
    wire [15:0] exponentii;
    
    
    Init init(A, B, exponentii2 , mantisele2);
    
    Mantisele m1(clear, load, clk, mantisele2, mantisele);
    Exponentii e1(clear, load, clk, exponentii2, exponentii);
    
    wire [8:0] diferenta;
    wire [56:0] dmantisele;
    
    
    ComparaExponenti comparaExponenti(exponentii, diferenta);
    Concatenare concatenare(mantisele, diferenta, dmantisele);
    
    
    wire [7:0] exponent;
    
    
    AlegeExponent alegeExponent(exponentii, exponent);
    
    
    wire [47:0] mantisele_aliniate;
    AliniereMantise aliniereMantise(dmantisele, mantisele_aliniate);
    
    
    wire [25:0] mantisa_res;
    AdunaScadeMantisele adunaScadeMantisele(mantisele_aliniate, mantisa_res, op);
    
    
    wire [4:0] diferenta_norm;
    wire [23:0] mantisa_norm;
    
    Normalizare norm(mantisa_res, diferenta_norm, mantisa_norm);
    
    wire [7:0] exponent_ajustat;
    AjustareExponent ajustareExponent(exponent, diferenta_norm, exponent_ajustat);
    
    
    assign C[31] = mantisa_norm[23];
    assign C[30:23] = exponent_ajustat[7:0];
    assign C[22:0] = mantisa_norm[22:0];
    
endmodule
