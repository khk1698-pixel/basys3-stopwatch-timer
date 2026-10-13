`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 16:12:05
// Design Name: 
// Module Name: up_counter_sync
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


module up_counter_sync(
    input clk,
    input reset_n,
    output [3:0] count
    );
    
    wire t2, t3;
    and (t2, count[0], count[1]);
    and (t3, t2, count[2]);
    
    T_flip_flop T0 (.T(1), .clk(clk), .Q(count[0]), .reset_n(reset_n), .preset_n(1));
    T_flip_flop T1 (.T(count[0]), .clk(clk), .Q(count[1]), .reset_n(reset_n), .preset_n(1));
    T_flip_flop T2 (.T(t2), .clk(clk), .Q(count[2]), .reset_n(reset_n), .preset_n(1));
    T_flip_flop T3 (.T(t3), .clk(clk), .Q(count[3]), .reset_n(reset_n), .preset_n(1));
    
endmodule

module up_counter_sync_BCD(
    input clk,
    input reset_n,
    output [3:0] count
    );
    
    wire t2, t3;
    and (t2, count[0], count[1]);
    and (t3, t2, count[2]);
    
    wire reset_10;
    nand (reset_10, count[3], count[1]);
    
    wire reset;
    and (reset, reset_n, reset_10);
    
    T_flip_flop T0 (.T(1), .clk(clk), .Q(count[0]), .reset_n(reset), .preset_n(1));
    T_flip_flop T1 (.T(count[0]), .clk(clk), .Q(count[1]), .reset_n(reset), .preset_n(1));
    T_flip_flop T2 (.T(t2), .clk(clk), .Q(count[2]), .reset_n(reset), .preset_n(1));
    T_flip_flop T3 (.T(t3), .clk(clk), .Q(count[3]), .reset_n(reset), .preset_n(1));
    
endmodule