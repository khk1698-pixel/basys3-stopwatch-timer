`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 13:22:05
// Design Name: 
// Module Name: encoder2_4
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


module encoder_4_2(
    input [3:0] D,
    output [1:0]B
    );
    
    or (B[0], D[1], D[3]);
    or (B[1], D[2], D[3]);
    
endmodule
