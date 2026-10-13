`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 15:12:19
// Design Name: 
// Module Name: up_counter
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


module up_counter(
    input clk,
    input reset_n,
    output [3:0] count
    );
    
    T_flip_flop T0 (.T(1), .clk(clk), .Q(count[0]), .reset_n(reset_n), .preset_n(1));
    T_flip_flop T1 (.T(1), .clk(count[0]), .Q(count[1]), .reset_n(reset_n), .preset_n(1));
    T_flip_flop T2 (.T(1), .clk(count[1]), .Q(count[2]), .reset_n(reset_n), .preset_n(1));
    T_flip_flop T3 (.T(1), .clk(count[2]), .Q(count[3]), .reset_n(reset_n), .preset_n(1));
    
    
endmodule


module down_counter(
    input clk,
    input reset_n,
    output [3:0] count
    );
    
    T_flip_flop_posedge T0 (.T(1), .clk(clk), .Q(count[0]), .reset_n(1), .preset_n(1));
    T_flip_flop_posedge T1 (.T(1), .clk(count[0]), .Q(count[1]), .reset_n(1), .preset_n(1));
    T_flip_flop_posedge T2 (.T(1), .clk(count[1]), .Q(count[2]), .reset_n(1), .preset_n(1));
    T_flip_flop_posedge T3 (.T(1), .clk(count[2]), .Q(count[3]), .reset_n(1), .preset_n(1));
    
    
endmodule