`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/25 17:01:25
// Design Name: 
// Module Name: watch_top_tb
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


module watch_top_tb();
    
    reg clk;
    reg [1:0] btn;
    wire [3:0] com_an;
    wire [6:0] seg_7;
    
    
    watch_top WT(
    .clk(clk), 
    .btn(btn),
    .com_an(com_an),
    .seg_7(seg_7)
    );
    initial clk=0;
    
    always #5 clk= ~clk;
    
    initial begin
        btn = 2'b00; #200;
        btn = 2'b01; #200;
        btn = 2'b10; #200;
        btn = 2'b11; #200;
    $finish;
    end
endmodule
