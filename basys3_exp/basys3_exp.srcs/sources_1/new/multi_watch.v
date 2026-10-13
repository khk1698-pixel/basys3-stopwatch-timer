`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/15 15:06:51
// Design Name: 
// Module Name: multi_watch
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

module multi_watch(
    input clk,
    input [4:0] btn,
    output [3:0] com_an,
    output [6:0] seg_7,
    output [3:0] led
);
    wire mode, clock_mode;
    wire [2:0] btn_stopwatch;
    wire [3:0] btn_cooktimer;
    wire [3:0] coman_stopwatch, coman_cooktimer;
    wire [6:0] seg7_stopwatch, seg7_cooktimer;
    
    clock_divider cd_16(.clk(clk), .sel(3), .clk_out(clk_160ns)); // 160ns
    clock_divider cd_256(.clk(clk_160ns), .sel(3), .clk_out(clk_2560ns)); // 2560ns
    clock_divider cd_4096(.clk(clk_2560ns), .sel(3), .clk_out(clk_40us)); // 40us
    
    //stopwatch
    stop_watch_top sw(.clk(clk), .btn(btn_stopwatch), .com_an(coman_stopwatch), .seg_7(seg7_stopwatch));
    //cooktimer
    cook_timer_top ct(.clk(clk), .btn(btn_cooktimer), .com_an(coman_cooktimer), .seg_7(seg7_cooktimer), .led(led));
    
    D_flip_flop_posedge dff4    (.D(btn[4]), .E(clk_40us), .Q(mode));
    
    T_flip_flop_posedge tff_mode (.T(1), .clk(mode), .reset_n(1), .preset_n(1), .Q(clock_mode));
    
    demux_1_2 selbtn0(.D(btn[0]), .S(clock_mode), .F({btn_stopwatch[0], btn_cooktimer[0]}));
    demux_1_2 selbtn1(.D(btn[1]), .S(clock_mode), .F({btn_stopwatch[1], btn_cooktimer[1]}));
    demux_1_2 selbtn2(.D(btn[2]), .S(clock_mode), .F({btn_stopwatch[2], btn_cooktimer[2]}));
    
    assign btn_cooktimer[3] = btn[3];
    
    assign com_an = (clock_mode) ? coman_stopwatch : coman_cooktimer;
    assign seg_7 = (clock_mode) ? seg7_stopwatch : seg7_cooktimer;
endmodule
