`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 13:29:21
// Design Name: 
// Module Name: decoder2_4
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


module decoder_2_4_tb( );

reg [1:0] A;
wire [3:0] Y;

decoder_2_4 DUT(
    .A(A),
    .Y(Y)
    );
    
initial begin
        A = 2'b00; #1000;
        A = 2'b01; #1000;
        A = 2'b10; #1000;
        A = 2'b11; #1000;
    $finish;
        
    end
    
endmodule
