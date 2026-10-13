`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 18:41:10
// Design Name: 
// Module Name: ultrasonic_top
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


module ultra_sonic_top(
    input clk,
    input echo,
    input btn,
    output trig,
    output [6:0] seg_7,
    output [3:0] com_an,
    output [7:0] led
    );
    
    wire [8:0] distance;
    wire [15:0] bcd_dis;
    wire reset_n;
    wire clk_160ns, clk_2560ns, clk_40us, debounced_btn;
    
    assign reset_n = ~debounced_btn;
    
    clock_divider cd_16(.clk(clk), .sel(3), .clk_out(clk_160ns));
    clock_divider cd_256(.clk(clk_160ns), .sel(3), .clk_out(clk_2560ns));
    clock_divider cd_4096(.clk(clk_2560ns), .sel(3), .clk_out(clk_40us));
    
    ultrasonic ultra(.clk(clk), .reset_n(reset_n), .echo(echo), .trig(trig), .distance(distance), .led(led));
    
    D_flip_flop_posedge ultrasonic_dff(.D(btn), .E(clk_40us), .Q(debounced_btn));
    
    bin_to_dec BTD_DIS(.bin({3'd0, distance}), .bcd(bcd_dis));
    
    FND_4digit_switcher ultrasonic_fnd(
    .value_1(bcd_dis[3:0]), .value_10(bcd_dis[7:4]), .value_100(bcd_dis[11:8]), .value_1000(bcd_dis[15:12]),
    .clk(clk), .com_an(com_an), .seg_7(seg_7));
    
endmodule
