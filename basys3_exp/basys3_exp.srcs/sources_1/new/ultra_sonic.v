`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 16:42:47
// Design Name: 
// Module Name: ultrasonic
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


module ultrasonic(
    input clk,
    input reset_n,
    input echo,
    output reg trig,
    output reg [8:0] distance,
    output reg [7:0] led
    );
    
    parameter S_IDLE        = 2'b00;
    parameter S_TRIG        = 2'b01;
    parameter S_ECHO        = 2'b10;
    parameter S_CAL_DIST    = 2'b11;
   
    reg [21:0] count_usec;
    reg count_usec_e = 0;
    reg [1:0] state = S_IDLE;
    reg [1:0] next_state = S_IDLE;
    reg detect_echo_nedge;
    reg [8:0] dist = 0;
    reg [5:0] cnt_dist = 0;
    wire echo_pedge;
    wire echo_nedge;
    reg [11:0] store_time = 0;
    
//    assign distance = store_time / 58;


    clock_usec usec_clk(.clk(clk), .reset_n(1), .clk_usec(clk_usec));
    
    always @(negedge clk_usec or negedge reset_n) begin
        if(!reset_n) begin
            count_usec = 0;
        end
        else if(count_usec_e) begin
            count_usec = count_usec + 1;
        end
        else begin
            count_usec = 0;
        end
    end
    
    always @(negedge clk_usec or negedge reset_n) begin
        if(!reset_n) begin
            state = S_IDLE;
        end
        else begin
            state = next_state;
        end
    end
    
    always @(negedge clk_usec or negedge reset_n) begin
        if(!reset_n) begin
            count_usec_e = 0;
        end
        else begin
            case(state)
                S_IDLE: begin
                    if(count_usec < 22'd1000000) begin
                        count_usec_e = 1;
                        trig = 0;
                        led = 0;
                        dist = 0;
                        cnt_dist = 0;
                    end
                    else begin
                        next_state = S_TRIG;
                        count_usec_e = 0;
                    end
                end
                S_TRIG: begin
                    if(count_usec < 15) begin
                        count_usec_e = 1;
                        trig = 1;
                        led[0] = 1;
                    end
                    else begin
                        count_usec_e = 0;
                        next_state = S_ECHO;
                        trig = 0;
                        led[1] = 1;
                    end
                end
                S_ECHO: begin
                    led[2] = 1;
                    if(count_usec < 50000) begin
                        if(echo_pedge) begin
                            led[3] = 1;
                            count_usec_e = 1;
                            next_state = S_CAL_DIST;
                        end
                        else begin
                            count_usec_e = 0;
                        end
                    end
                    else begin
                        next_state = S_IDLE;
                        count_usec_e = 0;
                    end
                end
                S_CAL_DIST: begin
                    if(count_usec < 50000) begin
                        led[5] = 1;
                        if(echo_nedge) begin
                            led[6] = 1;
                            next_state = S_IDLE;
                            count_usec_e = 0;
                            distance = dist;
                        end
                        else begin
                            led[4] = 1;
                            count_usec_e = 1;
                            if(cnt_dist > 57) begin
                                cnt_dist = 0;
                                dist = dist + 1;
                            end
                            else begin
                                cnt_dist = cnt_dist + 1;
                            end
                        end 
                     end
                     else begin
                        next_state = S_IDLE;
                        count_usec_e = 0;
                        dist = 0;
                        cnt_dist = 0;
                     end            
                end
                default: next_state = S_IDLE;
            endcase
        end
    end
    
    edge_detect ed1(.clk(clk_usec), .cp_in(echo), .reset_n(1), .p_edge(echo_pedge), .n_edge(echo_nedge));
    
endmodule
