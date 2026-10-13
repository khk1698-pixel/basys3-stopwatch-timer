`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/17 16:33:40
// Design Name: 
// Module Name: comparator
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


module comparator(
    input A,
    input B,
    output equal,
    output bigger,
    output less
    );
    
    wire Bbar, Abar;
    
    xnor (equal, A, B);
    not (Bbar, B);
    and (bigger, A, Bbar);
    not (Abar, A);
    and (less, Abar, B);
    
endmodule

module comparator_2bit(
    input [1:0] A,
    input [1:0] B,
    output reg equal,
    output reg bigger,
    output reg less
    );
    
    always @(A, B) begin
        if(A == B)begin
            equal = 1;
            bigger = 0;
            less = 0;
        end
        else if (A > B)begin
            equal = 0;
            bigger = 1;
            less = 0;
        end
        else begin
            equal = 0;
            bigger = 0;
            less = 1;
        end
    end
endmodule