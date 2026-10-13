`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 16:38:28
// Design Name: 
// Module Name: D_flip_flop
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


 module D_flip_flop(
    input D,
    input E,
    output Q,
    output Qbar
    );
    
    wire Dbar, S, R;
    
    not (Dbar, D);
    and (S, E, D);
    and (R, E, Dbar);
    
    SR_latch sr_latch(
        .S(S),
        .R(R),
        .Q(Q),
        .Qbar(Qbar)
    );
    
endmodule
