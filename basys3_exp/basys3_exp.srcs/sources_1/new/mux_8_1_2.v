`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 16:44:50
// Design Name: 
// Module Name: mux_8_1
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


module mux_8_1_2(
    input  [2:0] S,
    input  [5:0] D0, D1, D2, D3, D4, D5, D6, D7,
    output reg [5:0] F
    );
    
    always @ (S) begin
        case (S)
            3'b000 : F = D0;
            3'b001 : F = D1;
            3'b010 : F = D2;
            3'b011 : F = D3;
            3'b100 : F = D4;
            3'b101 : F = D5;
            3'b110 : F = D6;
            3'b111 : F = D7;
        endcase
    end
    
endmodule
