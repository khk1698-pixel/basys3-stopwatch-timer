`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 13:34:28
// Design Name: 
// Module Name: FND_4digit_switcher
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


module FND_4digit_switcher(
    input [3:0] value_1,
    input [3:0] value_10,
    input [3:0] value_100,
    input [3:0] value_1000,
    input clk,
    output reg [3:0] com_an = 4'b1110,
    output [7:0] seg_7
    );
//    reg [6:0] cnt_usec = 0;
//    reg [9:0] cnt_msec = 0;
    wire clk_usec, clk_msec;
    reg [3:0] hex_value;
    reg seg_dp;
    assign seg_7[7] = seg_dp;
//    wire clk_100MHz;
    
//    assign clk_100MHz = clk;
    
//     always @(negedge clk_100MHz)begin
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

//    clock_msec MCLK(.clk(clk), .clk_usec(clk_usec), .reset_n(1), .clk_msec(clk_msec));
//    clock_usec UCLK(.clk(clk), .reset_n(1), .clk_usec(clk_usec));
    
    wire clk_160ns, clk_2560ns, clk_409us, clk_819us;
    
    clock_divider cd_16(.clk(clk), .sel(3), .clk_out(clk_160ns));
    clock_divider cd_256(.clk(clk_160ns), .sel(3), .clk_out(clk_2560ns));
    clock_divider cd_4096(.clk(clk_2560ns), .sel(3), .clk_out(clk_40us));
    clock_divider cd_6550(.clk(clk_40us), .sel(3), .clk_out(clk_655us));
    
    decoder_7_seg dec7seg(.hex_value(hex_value), .seg_7(seg_7[6:0]));
    
    always @(negedge clk_40us)begin
        case (com_an)
            4'b1110 : begin
                com_an = 4'b1101;
                hex_value = value_10;
                seg_dp = 1'b1;
            end
            4'b1101 : begin
                com_an = 4'b1011;
                hex_value = value_100;
                seg_dp = 1'b1;
            end
            4'b1011 : begin
                com_an = 4'b0111;
                hex_value = value_1000;
                seg_dp = 1'b0;
            end
            4'b0111 : begin
                com_an = 4'b1110;
                hex_value = value_1;
                seg_dp = 1'b1;
            end
            default : begin
                com_an = 4'b1110;
                hex_value = value_1;
                seg_dp = 1'b1;
            end
        endcase
    end 
endmodule
