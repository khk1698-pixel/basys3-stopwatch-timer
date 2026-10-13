`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 14:12:19
// Design Name: 
// Module Name: T_flip_flop
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


module T_flip_flop(
    input T,
    input clk,
    input reset_n,
    input preset_n,
    output reg Q,
    output reg Qbar
    );
    
    initial begin
        Q = 0;
        Qbar = 1;
        end
    
    always @(negedge clk or negedge reset_n or negedge preset_n) begin
        if (!reset_n) begin
            Q = 0;
            Qbar = 1;
        end
        else if (!preset_n) begin
            Q = 1;
            Qbar = 0;
        end
        else begin
            if (T) begin
                Q = ~Q;
                Qbar = ~Qbar;
            end
            else if (!T) begin
                Q = Q;
                Qbar = Qbar;
            end
        end
    end
        
endmodule


module T_flip_flop_posedge(
    input T,
    input clk,
    input reset_n,
    input preset_n,
    output reg Q,
    output reg Qbar
    );
    
    initial begin
        Q = 0;
        Qbar = 1;
        end
    
    always @(posedge clk or negedge reset_n or negedge preset_n) begin
        if (!reset_n) begin
            Q = 0;
            Qbar = 1;
        end
        else if (!preset_n) begin
            Q = 1;
            Qbar = 0;
        end
        else begin
            if (T) begin
                Q = ~Q;
                Qbar = ~Qbar;
            end
            else if (!T) begin
                Q = Q;
                Qbar = Qbar;
            end
        end
    end
        
endmodule