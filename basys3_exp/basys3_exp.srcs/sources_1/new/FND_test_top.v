`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 14:05:30
// Design Name: 
// Module Name: FND_test_top
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


module FND_test_top(
    input clk,
    output [3:0] com_an,
    output [6:0] seg_7
    );
    
    FND_4digit_switcher FND_4digit(
        .value_1(4'd4), 
        .value_10(4'd3), 
        .value_100(4'd2), 
        .value_1000(4'd1),
        .clk(clk), 
        .com_an(com_an), 
        .seg_7(seg_7)
        );
            
endmodule
