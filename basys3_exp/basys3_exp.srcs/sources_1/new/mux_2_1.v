`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/18 16:28:42
// Design Name: 
// Module Name: mux_2_1
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


module mux_2_1(
    input [1:0] D,
    input S,
    output F
    );
    
    wire Sbar, in0, in1;
    
    not (Sbar, S);
    
    and (in0, D[0], Sbar);
    and (in1, D[1], S);
    
    or (F, in0, in1);
    
endmodule

module mux_4_1(
    input [3:0] D,
    input [1:0] S,
    output reg F
    );
    
    always @(*) begin
        case(S)
            0 : F = D[0];
            1 : F = D[1];
            2 : F = D[2];
            3 : F = D[3];
            default F = D[0];
            endcase
    end
endmodule
