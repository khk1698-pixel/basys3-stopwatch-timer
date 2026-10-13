`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/17 14:35:25
// Design Name: 
// Module Name: fadder_4bits
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


module fadder_4bits(
    input [3:0] A,
    input [3:0] B,
    input Cin,
    output [3:0] S,
    output Cout
    );
    wire [3:0] carry_out;
    assign carry_out[0] = Cin;
    assign Cout = carry_out[4];
    
    fadder fa0( .A(A[0]), .B(B[0]), .Cin(carry_out[0]), .S(S[0]), .Cout(carry_out[1]));
    fadder fa1( .A(A[1]), .B(B[1]), .Cin(carry_out[1]), .S(S[1]), .Cout(carry_out[2]));
    fadder fa2( .A(A[2]), .B(B[2]), .Cin(carry_out[2]), .S(S[2]), .Cout(carry_out[3]));
    fadder fa3( .A(A[3]), .B(B[3]), .Cin(carry_out[3]), .S(S[3]), .Cout(carry_out[4]));
    
endmodule


module fadder_4bits_for #(parameter N = 4)(
    input [N-1:0] A,
    input [N-1:0] B,
    input Cin,
    output [N-1:0] S,
    output Cout
    );
    
    wire [N:0] carry_out;
    assign carry_out[0] = Cin;
    assign Cout = carry_out[N];
    
    genvar i;
    
    generate
        for(i=0; i<N; i=i+1) begin
            fadder fa(.A(A[i]), .B(B[i]), .Cin(carry_out[i]), .S(S[i]), .Cout(carry_out[i+1]));
        end
    endgenerate        
    
endmodule