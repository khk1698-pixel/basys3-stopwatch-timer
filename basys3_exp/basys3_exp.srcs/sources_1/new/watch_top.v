`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/24 10:35:36
// Design Name: 
// Module Name: watch_top
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


module watch_top(
    input clk,
    input [1:0] btn,
    output [3:0] com_an,
    output [6:0] seg_7
    );
    
 //   wire  clk_sec;
    reg [3:0] sec [1:0];
    reg [3:0] min [1:0];
    wire [1:0] debounced_btn;
    
    clock_usec UCLK(.clk(clk), .reset_n(1), .clk_usec(clk_usec));
    clock_msec MCLK(.clk(clk), .clk_usec(clk_usec), .reset_n(1), .clk_msec(clk_msec));
    clock_sec SCLK(.clk(clk), .clk_msec(clk_msec), .reset_n(1), .clk_sec(clk_sec));
    clock_min CLK(.clk(clk), .clk_sec(inc_sec), .reset_n(1), .clk_min(clk_min));
    
    D_flip_flop_negedge dff_sec(.D(btn[0]), .E(clk_msec), .Q(debounced_btn[0]));
    D_flip_flop_negedge dff_min(.D(btn[1]), .E(clk_msec), .Q(debounced_btn[1]));
    
    xor (inc_sec, clk_sec, debounced_btn[0]);
    xor (inc_min, clk_min, debounced_btn[1]);
    
    always @(negedge inc_sec)begin
        if(sec[0] >= 9) begin
            sec[0] = 0;
            if (sec[1] >= 5) begin
                sec[1] = 0;
            end
            else sec[1] = sec[1] + 1;
        end
        else sec[0] = sec[0] + 1;
    end
    
    always @(negedge inc_min)begin
        if(min[0] >= 9) begin
            min[0] = 0;
            if (min[1] >= 5) begin
                min[1] = 0;
            end
            else min[1] = min[1] + 1;
        end
        else min[0] = min[0] + 1;
    end
    
    FND_4digit_switcher FND_4digit(
        .value_1(sec[0]), 
        .value_10(sec[1]), 
        .value_100(min[0]), 
        .value_1000(min[1]),
        .clk(clk), 
        .com_an(com_an), 
        .seg_7(seg_7)
        );
    
endmodule
