`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/27 18:41:00
// Design Name: 
// Module Name: cook_timer_tb
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


module cook_timer_tb( );

    reg clk;
    reg [3:0] btn;
    wire [6:0] seg_7;
    wire [3:0] com_an;
    wire led;
    
    cook_timer_top ct(.clk(clk), .btn(btn), .com_an(com_an), .seg_7(seg_7), .led(led));
    
    initial begin
        clk = 0;
        btn = 0;
    end
    
    always #5 clk= ~clk;
    
    initial begin
        btn = 4'b0100; #1000
        btn = 4'b0000; #100000
        btn = 4'b0001; #100000
        btn = 4'b0000; #100000
        btn = 4'b0001; #100000
        btn = 4'b0000; #100000
        btn = 4'b1000; #100000
        btn = 4'b0000; #100000
        btn = 4'b0010; #100000
        btn = 4'b0000; #1130000
        btn = 4'b0000; #100000
        btn = 4'b0001; #100000
        btn = 4'b0000; #100000
        btn = 4'b0001; #100000
        btn = 4'b0000; #100000
        btn = 4'b1000; #100000
        btn = 4'b0000; #100000
        btn = 4'b0010; #100000
        btn = 4'b0000; #100000
        btn = 4'b0100; #1000
        btn = 4'b0000; #100000
        $finish;
    end
endmodule
