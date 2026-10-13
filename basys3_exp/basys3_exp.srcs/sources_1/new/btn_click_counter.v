`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 10:21:26
// Design Name: 
// Module Name: btn_click_counter
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


module btn_click_counter(
    input clk,
    input button,
    output [3:0] com_an,
    output [6:0] seg_7,
    output [3:0] led
    );
    
    wire [3:0] count_value;
    wire debounced_button;
//    wire clk_100MHz;
//    reg [6:0]cnt_usec;
//    reg [10:0]cnt_msec;
    wire clk_usec, clk_msec;
    
//    initial begin
//        cnt_usec = 0;
//        cnt_msec = 0;
//        clk_usec = 0;
//        clk_msec = 0;
//    end
    
    assign led = count_value;
//    assign clk_100MHz = clk;
    
//    always @(negedge clk_100MHz)begin
//        if(cnt_usec >= 99) cnt_usec =0;
//        else cnt_usec = cnt_usec + 1;
//        if(cnt_usec <= 49) clk_usec = 0;
//        else clk_usec = 1;
//    end
    
//    always @(negedge clk_usec)begin
//        if(cnt_msec >= 999) cnt_msec =0;
//        else cnt_msec = cnt_msec + 1;
//        if(cnt_msec <= 499) clk_msec = 0;
//        else clk_msec = 1;
//    end
    clock_msec MCLK(.clk(clk), .clk_usec(clk_usec), .clk_msec(clk_msec));
    clock_usec UCLK(.clk(clk), .clk_usec(clk_usec));
    
    up_counter_sync_BCD ucounter(.clk(debounced_button), .reset_n(1), .count(led));
    decoder_7_seg decoder(.hex_value(count_value), .seg_7(seg_7), .com_an(com_an));
    D_flip_flop_posedge dff1(.D(button), .E(clk_msec), .Q(debounced_button));
endmodule
