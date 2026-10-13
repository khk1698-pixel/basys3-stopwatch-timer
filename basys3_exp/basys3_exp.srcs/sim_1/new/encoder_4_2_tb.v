`timescale 1ns / 1ps // 단위 / 정밀도
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 13:35:10
// Design Name: 
// Module Name: encoder_4_2_tb
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


module encoder_4_2_tb( );
    
    reg [3:0] D;
    wire [1:0] B;
    
encoder_4_2 DUT(
    .D(D),
    .B(B)
    );
    
    initial begin
        D = 4'b0001; #1000;
        D = 4'b0010; #1000;
        D = 4'b0100; #1000;
        D = 4'b1000; #1000;
        $finish;
        
    end
    
endmodule
