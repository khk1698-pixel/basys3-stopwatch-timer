`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/02 17:12:27
// Design Name: 
// Module Name: fadder_4bit_for_tb
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


module fadder_4bit_for_tb( );

    fadder_4bits_for #(.N(8)) fa(.A(A), .B(B), .Cin(Cin), .S(S), .Cout(Cout));
    
    reg [7:0] A, B;
    reg Cin;
    wire [7:0]S;
    wire Cout;
    
    initial begin
        A = 8'd136;
        B = 8'd197;
        Cin= 0;
    end
endmodule
