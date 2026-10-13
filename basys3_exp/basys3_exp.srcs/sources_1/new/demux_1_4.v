`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 09:44:37
// Design Name: 
// Module Name: demux_1_4
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


module demux_1_4(
    input D,
    input [1:0] S,
    output [3:0] F
    );
    
    wire [1:0] Sbar;
    
    not (Sbar[0], S[0]);
    not (Sbar[1], S[1]);
    
    and (F[0], D, Sbar[1], Sbar[0]);
    and (F[1], D, Sbar[1], S[0]);
    and (F[2], D, S[1], Sbar[0]);
    and (F[3], D, S[1], S[0]);
    
endmodule

module demux_1_2(
    input D,
    input S,
    output [1:0] F
);

    wire Sbar;
    
    not (Sbar, S);
    
    and (F[0], D, Sbar);
    and (F[1], D, S);
    
endmodule

module mux_4_1(
    input [3:0] D,
    input [1:0] S,
    output reg F
);
    
    always @(*) begin
        case (S)
            0 : F = D[0];
            1 : F = D[1];
            2 : F = D[2];
            3 : F = D[3];
            default : F = D[0];
        endcase
    end

endmodule
