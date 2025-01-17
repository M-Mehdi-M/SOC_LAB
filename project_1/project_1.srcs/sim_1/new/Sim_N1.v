`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2024 08:34:02 AM
// Design Name: 
// Module Name: Sim_N1
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

module sim_N1( );
    reg A, B ,C;
    wire D;
    reg [8*100:1] olinie;
    integer fd,count, status, i_A, i_B, i_C, i_D, erori;
   
    design_1_wrapper top(A, B, C, D);

    initial begin
        A = 1'bx; B = 1'bx; C = 1'bx;
        fd= $fopen("../../../input.txt","r");
        if(fd==0)
            fd=$fopen("../../../../input.txt","r");
        count=1;
        #100
        erori=0;
        while($fgets(olinie,fd))
        begin    
            status=$sscanf(olinie,"%d %d %d", i_A, i_B, i_C, i_D);
            A=i_A; B=i_B; C=i_C;
            #50
            if(i_D==D)
                $display("%d(%t) ok, A=%d, B=%d, C=%c, D=%d\n",count, $time, A, B, C, D);
            else begin 
            erori=erori+1;
                $display("%d(%t): EROAREL, A=%d, B=%d, C=%d, D(actual)=%, D(corect)=%d\n",count, $time, A, B, C, D);
           end
           count=count+1; 
    end
    #50 A=1'bx; B=1'bx; C=1'bx;
    #50 $stop;
    #50 $finish;
    end
endmodule
