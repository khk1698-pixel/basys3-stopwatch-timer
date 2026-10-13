`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 16:26:13
// Design Name: 
// Module Name: SR_latch_Enable
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


module SR_latch_Enable(
    input S,
    input R,
    input E,
    output Q,
    output Qbar
    );
    
    wire wr, ws;
    
    and (wr, R, E);
    and (ws, S, E);
    
    SR_latch sr_latch(
    .R(wr),
    .S(ws),
    .Q(Q),
    .Qbar(Qbar)
    );
    
endmodule
