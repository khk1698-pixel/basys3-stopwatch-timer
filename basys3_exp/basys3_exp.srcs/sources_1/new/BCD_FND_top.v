`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 14:40:35
// Design Name: 
// Module Name: BCD_FND_top
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


module BCD_FND_top(
    input [3:0] in_bin,
    output [6:0] seg_7,
    output [3:0] com_an
    );
    
    wire [15:0] w_bcd;
    
bin_to_dec BTD(
    .bin({8'd0, in_bin}),
    .bcd(w_bcd)
    );
    
    decoder_7_seg SEG(
    .hex_value(w_bcd[7:4]),
    .seg_7(seg_7),
    .com_an(com_an)
    );
    
    
    
endmodule
