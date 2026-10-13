`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/24 14:22:44
// Design Name: 
// Module Name: stop_watch_top
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


module stop_watch_top(
    input clk,
    input [2:0] btn,
    output [3:0] com_an,
    output [6:0] seg_7
    );
    
    wire btn_start, btn_stop;
    wire reset_n, start ,clk_start;
    reg [3:0] sec [1:0];
    reg [3:0] min [1:0];
    reg [3:0] lap [3:0];
    reg [3:0] out_value [3:0];
    
    wire [3:0] w_sec [1:0];         //시뮬레이션 가동을 위해
    wire [3:0] w_min [1:0];
    wire [3:0] w_lap [3:0];
    
    assign w_sec[0] = sec[0];
    assign w_sec[1] = sec[1];
    assign w_min[0] = min[0];
    assign w_min[1] = min[1];
    assign w_lap[0] = lap[0];
    assign w_lap[1] = lap[1];
    assign w_lap[2] = lap[2];
    assign w_lap[3] = lap[3];
    
    always @(lap_e,  w_sec[0], w_sec[1],
                     w_min[0], w_min[1],
                     w_lap[0], w_lap[1], w_lap[2], w_lap[3])begin
        if(lap_e)begin
            out_value[0] = lap[0];
            out_value[1] = lap[1];
            out_value[2] = lap[2];
            out_value[3] = lap[3];
        end
        else begin
            out_value[0] = sec[0];
            out_value[1] = sec[1];
            out_value[2] = min[0];
            out_value[3] = min[1];
        end
    end
    
    always @(posedge btn_lap or negedge reset_n)begin
        if(!reset_n)begin
            lap[0] = 0;
            lap[1] = 0;
            lap[2] = 0;
            lap[3] = 0;
        end
        else begin
            lap[0] = sec[0];
            lap[1] = sec[1];
            lap[2] = min[0];
            lap[3] = min[1];
        end
    end    
    
    not (reset_n, btn[2]);
    
    T_flip_flop_posedge tff_start(.T(1), .clk(btn_start), .reset_n(reset_n), .preset_n(1), .Q(start));
    T_flip_flop_posedge tff_lap(.T(1), .clk(btn_lap), .reset_n(reset_n), .preset_n(1), .Q(lap_e));
    
    and (clk_start, start, clk_msec);
    
    always @(negedge clk_sec or negedge reset_n)begin
        if(!reset_n)begin
            sec[0]=0;
            sec[1]=0;
        end
        else begin
            if(sec[0] >= 9) begin
                sec[0] = 0;
                if (sec[1] >= 5) begin
                    sec[1] = 0;
                end
                else sec[1] = sec[1] + 1;
            end
            else sec[0] = sec[0] + 1;
        end
    end
    
    always @(negedge clk_min or negedge reset_n)begin
        if(!reset_n)begin
            min[0]=0;
            min[1]=0;
        end
            else begin
            if(min[0] >= 9) begin
                min[0] = 0;
                if (min[1] >= 5) begin
                    min[1] = 0;
                end
                else min[1] = min[1] + 1;
            end
            else min[0] = min[0]+1;
        end
    end
    
    D_flip_flop_posedge dff_start(.D(btn[0]), .E(clk_msec), .Q(btn_start));
    D_flip_flop_posedge dff_lap(.D(btn[1]), .E(clk_msec), .Q(btn_lap));
    
    
    clock_usec UCLK(.clk(clk), .reset_n(reset_n), .clk_usec(clk_usec));
    clock_msec MCLK(.clk(clk), .clk_usec(clk_usec), .reset_n(reset_n), .clk_msec(clk_msec));
    clock_sec SCLK(.clk(clk), .clk_msec(clk_start), .reset_n(reset_n), .clk_sec(clk_sec));
    clock_min CLK(.clk(clk), .clk_sec(clk_sec), .reset_n(reset_n), .clk_min(clk_min));
    
     FND_4digit_switcher FND_4digit(
        .value_1(out_value[0]), 
        .value_10(out_value[1]), 
        .value_100(out_value[2]), 
        .value_1000(out_value[3]),
        .clk(clk),
        .com_an(com_an), 
        .seg_7(seg_7)
        );
    
endmodule
