`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 13:29:21
// Design Name: 
// Module Name: decoder2_4
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


module decoder_2_4(
    input [1:0] A,
    output [3:0] Y
    );
    
    wire [1:0] Abar;
    
    not (Abar[0], A[0]);
    not (Abar[1], A[1]);
    
    and (Y[0], Abar[0], Abar[1]);
    and (Y[1], A[0], Abar[1]);
    and (Y[2], Abar[0], A[1]);
    and (Y[3], A[0], A[1]);
    
endmodule
