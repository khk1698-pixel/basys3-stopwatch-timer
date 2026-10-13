`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 11:31:06
// Design Name: 
// Module Name: JK_flip_flop
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


module JK_flip_flop(
    input J,
    input K,
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
    
    always @(posedge clk or negedge reset_n or negedge preset_n)begin
        if (!reset_n) begin
            Q = 0;
            Qbar = 1;
        end
        else if(!preset_n) begin
            Q = 1;
            Qbar = 0;
        end
        else begin
            case({J, K})
                2'b00 : begin
                    Q = Q;
                    Qbar = Qbar;
                end
                2'b01 : begin
                    Q = 0;
                    Qbar = 1;
                end
                2'b10 : begin
                    Q = 1;
                    Qbar = 0;
                end
                2'b11 : begin
                    Q = ~Q;
                    Qbar = ~Qbar;
                end
            endcase
        end
    end 
endmodule
