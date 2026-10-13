`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/20 10:31:30
// Design Name: 
// Module Name: D_flip_flop_edge_trig
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


module D_flip_flop_posedge(
    input D,
    input E,
    output Q,
    output Qbar
    );
    
    wire Ebar, QX;
    
    not (Ebar, E);
    
    D_flip_flop DFF1(.D(D), .E(Ebar), .Q(QX));
    
    D_flip_flop DFF2(.D(QX), .E(E), .Q(Q), .Qbar(Qbar));
    
    
endmodule

module D_flip_flop_negedge(
    input D,
    input E,
    output Q,
    output Qbar
    );
    
    wire Ebar, QX;
    
    not (Ebar, E);
    
    D_flip_flop DFF1(.D(D), .E(E), .Q(QX));
    
    D_flip_flop DFF2(.D(QX), .E(Ebar), .Q(Q), .Qbar(Qbar));
    
    
endmodule
