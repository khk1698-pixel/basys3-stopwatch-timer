`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 16:44:50
// Design Name: 
// Module Name: mux_8_1
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


module mux_8_1(
    input [2:0] S,
    input [7:0] D,
    output F
    );
    
    
    wire [2:0] Sbar;
    wire [7:0] DF;
    
    not (Sbar[0], S[0]);
    not (Sbar[1], S[1]);
    not (Sbar[2], S[2]);
    
    and (DF[0], D[0],  Sbar[2], Sbar[1], Sbar[0]);
    and (DF[1], D[1], Sbar[2], Sbar[1], S[0]);
    and (DF[2], D[2], Sbar[2], S[1], Sbar[0]);
    and (DF[3], D[3], Sbar[2], S[1], S[0]);
    and (DF[4], D[4], S[2], Sbar[1], Sbar[0]);
    and (DF[5], D[5], S[2], Sbar[1], S[0]);
    and (DF[6], D[6], S[2], S[1], Sbar[0]);
    and (DF[7], D[7], S[2], S[1], S[0]);
    
    or (F, DF[0], DF[1], DF[2], DF[3], DF[4], DF[5], DF[6], DF[7]);
    
    
endmodule
