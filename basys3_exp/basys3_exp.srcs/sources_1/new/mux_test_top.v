`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 10:27:10
// Design Name: 
// Module Name: mux_test_top
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


module mux_test_top(
    input [7:0] D,
    input [2:0] S_mux,
    input [1:0] S_demux,
    output [3:0] F
    );
    
    wire W;
    
    mux_8_1 mux(
    .S(S_mux),
    .D(D),
    .F(W)
    );
    
    demux_1_4 demux(
    .D(W),
    .S(S_demux),
    .F(F)
    );
    
endmodule
