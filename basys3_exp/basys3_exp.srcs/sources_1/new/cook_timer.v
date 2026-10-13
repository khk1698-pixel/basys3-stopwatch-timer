`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/25 11:35:08
// Design Name: 
// Module Name: cook_timer
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


module cook_timer_top(
    input clk,
    input [3:0] btn,
    output [3:0] com_an,
    output [6:0] seg_7,
    output [3:0] led
    );
    
    wire reset_n;
    wire dec_clk;
    wire btn_down, btn_inc_sec, btn_inc_min, btn_reset;
    wire clk_up_down_sec, reset_edge;
    wire down;
    
    wire [3:0] sec [1:0];
    wire [3:0] min [1:0];
    reg time_out;
    wire led_on;
    
    
   
    assign reset_n = ~reset_edge;
    
    D_flip_flop_posedge dff_down (.D(btn[1]), .E(clk_msec), .Q(btn_down));
    D_flip_flop_posedge dff_incsec (.D(btn[3]), .E(clk_msec), .Q(btn_inc_sec));
    D_flip_flop_posedge dff_incmin (.D(btn[0]), .E(clk_msec), .Q(btn_inc_min));
    D_flip_flop_posedge dff_reset (.D(btn[2]), .E(clk_msec), .Q(btn_reset));
    
    edge_detect ed_reset(.clk(clk), .cp_in(btn_reset), .reset_n(1), .n_edge(reset_edge));
    
    clock_usec UCLK(.clk(clk), .reset_n(reset_n), .clk_usec(clk_usec));
    clock_msec MCLK(.clk(clk), .clk_usec(clk_usec), .reset_n(reset_n), .clk_msec(clk_msec));
    clock_sec SCLK(.clk(clk), .clk_msec(clk_msec), .reset_n(reset_n), .clk_sec(clk_sec));
    clock_min CLK(.clk(clk), .clk_sec(clk_sec), .reset_n(reset_n), .clk_min(clk_min));
    
     FND_4digit_switcher FND_4digit(
        .value_1(sec[0]), 
        .value_10(sec[1]), 
        .value_100(min[0]), 
        .value_1000(min[1]),
        .clk(clk),
        .com_an(com_an), 
        .seg_7(seg_7)
        );
    
    always@(posedge clk)begin
        time_out = |{sec[0], sec[1], min[0], min[1]};
    end
        
    T_flip_flop_posedge tff_start(.T(1), .clk(btn_down), .reset_n(time_out), .preset_n(1), .Q(down));
    
    not(btn_down_n, btn_down);
    not(btn_incsec_n, btn_inc_sec);
    not(btn_incmin_n, btn_inc_min);
    and(any_btn, btn_down_n, btn_incsec_n, btn_incmin_n);
    
    T_flip_flop tff_led(.T(1), .clk(time_out), .reset_n(any_btn), .preset_n(1), .Q(led_on));
    
    assign led[0] = led_on;    
    
    mux_2_1 mux_sec(
        .D({clk_sec, btn_inc_sec}),
        .S(down),
        .F(clk_up_down_sec)
    );
//      위와 같은 내용    
//    and (clk_down_sec, down, clk_sec);
//    and (clk_up_sec, ~down, btn_incsec);
//    or (clk_up_down_sec, clk_down_sec, clk_up_sec);
    
    counter_up_down counter_sec(
        .clk(clk_up_down_sec),
        .down(down),
        .reset_n(reset_n),
        .count_1(sec[0]),
        .count_10(sec[1]),
        .dec_clk(dec_clk)
    );
    
    wire dec_clk_negedge;
    
    edge_detect ed_clk_min(.clk(clk), .cp_in(dec_clk), .reset_n(reset_n), .n_edge(dec_clk_negedge));
    
    mux_2_1 mux_min(
        .D({dec_clk_negedge, btn_inc_min}),
        .S(down),
        .F(clk_up_down_min)
    );
    
    counter_up_down counter_min(
        .clk(clk_up_down_min),
        .down(down),
        .reset_n(reset_n),
        .count_1(min[0]),
        .count_10(min[1])
    );
    
endmodule


module counter_up_down(
    input clk,
    input down,
    input reset_n,
    output reg [3:0] count_1 = 0,
    output reg [3:0] count_10 = 0,
    output reg dec_clk=0
);

    always @(negedge clk or negedge reset_n)begin
        if(!reset_n)begin
            count_1 = 0;
            count_10 = 0;
            dec_clk = 1;
        end
        else begin
            if(down)begin   //down = 1
                if(count_1 == 0)begin
                    count_1 = 9;
                    if(count_10 == 0) begin
                        count_10 = 5;
                        dec_clk = 0;
                    end
                    else count_10 = count_10 - 1;
                end
                else begin
                    count_1 = count_1 - 1;
                    if(~|{count_1, count_10}) dec_clk = 1; // ~(각 비트를 다 or 연산 하나라도 1이면 1) => 0
                end
            end
            else begin  //down = 0
                dec_clk = 0;
                if(count_1 >= 9) begin
                    count_1 = 0;
                    if(count_10 >= 5)begin
                        count_10 = 0;
                        dec_clk = 1;
                    end
                    else count_10 = count_10 + 1;
                end
                else count_1 = count_1 + 1;
            end
        end
    end
        
endmodule