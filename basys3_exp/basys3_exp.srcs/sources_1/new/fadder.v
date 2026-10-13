`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/17 13:46:10
// Design Name: 
// Module Name: fadder
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


module fadder(
    input A,
    input B,
    input Cin,
    output S,
    output Cout
    );
    
    wire s0, co0, co1;
    
    half_adder ha0(.A(A), .B(B), .S(s0), .C(co0));
    half_adder ha1(.A(s0), .B(Cin), .S(S), .C(co1));
    
    or (Cout, co0, co1);
    
endmodule

