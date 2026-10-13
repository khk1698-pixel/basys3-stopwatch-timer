`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 11:36:30
// Design Name: 
// Module Name: shift_register_SISO
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


module shift_register_SISO(
    input D,
    input clk,
    input reset_n,
    output Q
    );
    
    wire [2:0] w;
    
    D_flip_flop_negedge DFF0(.D(D), .E(clk), .Q(w[0]));
    D_flip_flop_negedge DFF1(.D(w[0]), .E(clk), .Q(w[1]));
    D_flip_flop_negedge DFF2(.D(w[1]), .E(clk), .Q(w[2]));
    D_flip_flop_negedge DFF3(.D(w[2]), .E(clk), .Q(Q));
    
endmodule


module shift_register_SIPO(     //구조적
    input D,
    input clk,
    input rd_e_n,
    output [3:0] Q
    );
    
    wire [3:0] w;
    
    D_flip_flop_negedge DFF0(.D(D), .E(clk), .Q(w[3]));
    D_flip_flop_negedge DFF1(.D(w[3]), .E(clk), .Q(w[2]));
    D_flip_flop_negedge DFF2(.D(w[2]), .E(clk), .Q(w[1]));
    D_flip_flop_negedge DFF3(.D(w[1]), .E(clk), .Q(w[0]));
    
    bufif0 (Q[0], w[0], rd_e_n);      //Q => wire
    bufif0 (Q[1], w[1], rd_e_n);
    bufif0 (Q[2], w[2], rd_e_n);
    bufif0 (Q[3], w[3], rd_e_n);
    
//    always @(posedge clk)begin        //Q => reg
//        if(!rd_e_n)begin
//            Q = w;
//        end
//        else begin
//            Q = 4'bz; // 임피던스
//        end
//    end

    assign Q = rd_e_n ? 4'bz : w;       //Q => wire
    
endmodule

module shift_register_SIPO_b(       //동작적
    input D,
    input clk,
    input rd_e_n,
    output reg [3:0] Q
    );
    
    reg [3:0] w;
    
    always @(negedge clk) begin
        w[3] <= D;
        w[2] <= w[3];
        w[1] <= w[2];
        w[0] <= w[1];
    end
    
    always @(rd_e_n)begin        //Q => reg
        if(!rd_e_n)begin
            Q = w;
        end
        else begin
            Q = 4'bz; // 임피던스
        end
    end

endmodule

module shift_register_PISO(
    input [3:0] D,
    input clk,
    input shift_load,
    output Q
    );
    
    wire [2:0] dff_o;
    wire [2:0] mux_o;
    
    D_flip_flop_negedge DFF0(.D(D), .E(clk), .Q(dff_o[2]));
    D_flip_flop_negedge DFF1(.D(mux_o[2]), .E(clk), .Q(dff_o[1]));
    D_flip_flop_negedge DFF2(.D(mux_o[1]), .E(clk), .Q(dff_o[0]));
    D_flip_flop_negedge DFF3(.D(mux_o[0]), .E(clk), .Q(Q));
    
    mux_2_1 mux2(.D({dff_o[2], D[2]}), .S(shift_load), .F(mux_o[2]));
    mux_2_1 mux1(.D({dff_o[1], D[1]}), .S(shift_load), .F(mux_o[1]));
    mux_2_1 mux0(.D({dff_o[0], D[0]}), .S(shift_load), .F(mux_o[0]));
    
endmodule


module register_PIPO(
    input [3:0] D,
    input clk,
    input wr_e_p, rd_e_n,
    output [3:0] Q
    );
    
    wire [3:0] dff_o;
    wire [3:0] and_o;
    wire [3:0] F;
    
    mux_2_1 mx00 (.D({D[0], dff_o[0]}), .S(wr_e_p), .F(F[0]));
    mux_2_1 mx01 (.D({D[1], dff_o[1]}), .S(wr_e_p), .F(F[1]));
    mux_2_1 mx02 (.D({D[2], dff_o[2]}), .S(wr_e_p), .F(F[2]));
    mux_2_1 mx03 (.D({D[3], dff_o[3]}), .S(wr_e_p), .F(F[3]));
    
    and (and_o[0], F[0], reset_n);
    and (and_o[1], F[1], reset_n);
    and (and_o[2], F[2], reset_n);
    and (and_o[3], F[3], reset_n);
    
    D_flip_flop_negedge DFF0(.D(and_o[3]), .E(clk), .Q(dff_o[3]));
    D_flip_flop_negedge DFF1(.D(and_o[2]), .E(clk), .Q(dff_o[2]));
    D_flip_flop_negedge DFF2(.D(and_o[1]), .E(clk), .Q(dff_o[1]));
    D_flip_flop_negedge DFF3(.D(and_o[0]), .E(clk), .Q(dff_o[0]));
    
    bufif0 (Q[0], dff_o[0], rd_e_n);
    bufif0 (Q[1], dff_o[1], rd_e_n);
    bufif0 (Q[2], dff_o[2], rd_e_n);
    bufif0 (Q[3], dff_o[3], rd_e_n);
    
endmodule


module register_N_bit_negedge #(parameter N = 8)(
    input [N-1:0] D,
    input clk,
    input reset_p,
    input wr_e_p, rd_e_n,
    output [N-1:0] Q,
    output [N-1:0] tri_s_Q
    );
    
    wire [N-1:0] and_o;
    wire [N-1:0] F;
    
    genvar i;
    
    generate 
        for (i=0; i<N; i=i+1)begin
            mux_2_1 mx(.D({D[i], Q[i]}), .S(wr_e_p), .F(F[i]));
            and (and_o[i], F[i], ~reset_p) ;
            D_flip_flop_negedge DFF(.D(and_o[i]), .E(clk), .Q(Q[i]));
            bufif1 (tri_s_Q[i], Q[i], rd_e_n);
        end
    endgenerate
    
endmodule