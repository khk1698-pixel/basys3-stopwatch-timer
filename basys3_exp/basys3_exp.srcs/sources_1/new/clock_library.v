`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/21 16:12:12
// Design Name: 
// Module Name: clock_library
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


module clock_usec(
    input clk,
    input reset_n,
    output clk_usec
    );
    
    wire clk_100MHz;
    reg [6:0] cnt_usec = 0;
    reg reg_usec = 0;
    
    edge_detect ed_usec(.clk(clk), .cp_in(reg_usec), .reset_n(1), .n_edge(clk_usec));
    
    assign clk_100MHz=clk;
    
    always @(negedge clk_100MHz or negedge reset_n)begin
        if(!reset_n) begin
            cnt_usec = 0;
            reg_usec = 0;
        end
        else begin
            if(cnt_usec >= 49) begin
                cnt_usec =0;
                reg_usec = ~reg_usec;
            end
            else cnt_usec = cnt_usec + 1;
        end
    end
endmodule

module clock_msec(
    input clk,
    input clk_usec,
    input reset_n,
    output clk_msec
    );
    
    reg [8:0] cnt_msec = 0;
    reg reg_msec = 0;
    
    edge_detect ed_msec(.clk(clk), .cp_in(reg_msec), .reset_n(1), .n_edge(clk_msec));
    
    always @(negedge clk_usec or negedge reset_n)begin
        if(!reset_n) begin
            cnt_msec = 0;
            reg_msec = 0;
        end
        else begin
            if(cnt_msec >= 499) begin 
                cnt_msec =0;
                reg_msec = ~reg_msec;
            end
            else cnt_msec = cnt_msec + 1;
        end
    end
endmodule

module clock_sec(
    input clk,
    input clk_msec,
    input reset_n,
    output clk_sec
    );
    
    reg [9:0] cnt_sec = 0;
    reg reg_sec = 0;
    
    edge_detect ed_sec(.clk(clk), .cp_in(reg_sec), .reset_n(1), .n_edge(clk_sec));
    
    always @(negedge clk_msec or negedge reset_n)begin
        if(!reset_n) begin
            cnt_sec = 0;
            reg_sec = 0;
        end
        else begin
            if(cnt_sec >= 499) begin 
                cnt_sec =0;
                reg_sec = ~reg_sec;
            end
            else cnt_sec = cnt_sec + 1;
        end
    end
endmodule

module clock_min(
    input clk,
    input clk_sec,
    input reset_n,
    output clk_min
    );
    
    reg [9:0] cnt_min = 0;
    reg reg_min = 0;
    
    edge_detect ed_min(.clk(clk), .cp_in(reg_min), .reset_n(1), .n_edge(clk_min));
    
    always @(negedge clk_sec or negedge reset_n)begin
        if(!reset_n) begin
            cnt_min = 0;
            reg_min = 0;
        end
        else begin
            if(cnt_min >= 29) begin
                cnt_min = 0;
                reg_min = ~reg_min;
            end
            else cnt_min = cnt_min + 1;
//            if(cnt_min <= 29) clk_min = 0;      //High레벨인 시간을 최소화 : 그 다음 클럭에서 하강엣지로 인식하여 1을 증가시킬 수 있어서
        end
    end
endmodule

module edge_detect(
    input clk,
    input cp_in,
    input reset_n,
    output p_edge,
    output n_edge
    );
    
    reg cp_in_old, cp_in_cur;
    
    always @(negedge clk or negedge reset_n)begin
        if (!reset_n)begin
            cp_in_old = 0;
            cp_in_cur = 0;
        end
        else begin
            cp_in_old <= cp_in_cur;
            cp_in_cur <= cp_in;
        end
    end
    assign p_edge = ~cp_in_old & cp_in_cur;
    assign n_edge = cp_in_old & ~cp_in_cur;
    
endmodule


module clock_divider(
    input clk,
    input [1:0] sel,
    output clk_out
    );
    
    wire [3:0] clk_divided;
    
    T_flip_flop T0 (.T(1), .clk(clk), .Q(clk_divided[0]), .reset_n(1), .preset_n(1));
    T_flip_flop T1 (.T(1), .clk(clk_divided[0]), .Q(clk_divided[1]), .reset_n(1), .preset_n(1));
    T_flip_flop T2 (.T(1), .clk(clk_divided[1]), .Q(clk_divided[2]), .reset_n(1), .preset_n(1));
    T_flip_flop T3 (.T(1), .clk(clk_divided[2]), .Q(clk_divided[3]), .reset_n(1), .preset_n(1));
    
    mux_4_1 mux(.D(clk_divided), .S(sel), .F(clk_out));
    
endmodule