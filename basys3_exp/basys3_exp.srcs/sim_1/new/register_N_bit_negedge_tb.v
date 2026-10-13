`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/02 10:28:05
// Design Name: 
// Module Name: register_N_bit_negedge_tb
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


module register_N_bit_negedge_tb( );
    
    reg [7:0] D;
    reg clk;
    reg reset_p;
    reg wr_e_p, rd_e_n;
    wire [7:0] Q, tri_s_Q;
    reg [7:0] Data;

    register_N_bit_negedge #(.N(8)) n(.D(D), .clk(clk), .reset_p(reset_p), .wr_e_p(wr_e_p), .rd_e_n(rd_e_n), .Q(Q), .tri_s_Q(tri_s_Q));
    
    initial begin
        D = 0;
        clk = 0;
        rd_e_n = 0;
        wr_e_p = 0;
        Data = 8'b10101011;
        reset_p = 0;
    end
    
    always #5 clk= ~clk;
    
    initial begin
    D = Data;
    reset_p = 0;#1000
    rd_e_n = 1;#1000
    rd_e_n = 0;#1000
    wr_e_p = 1;#1000
    wr_e_p = 0;#1000
    rd_e_n = 1;#1000
    wr_e_p = 1;#1000
    wr_e_p = 0;
    rd_e_n = 0;
    reset_p = 1;#1000
    wr_e_p = 1;#1000
    wr_e_p = 0;
    rd_e_n = 1;#1000
    wr_e_p = 1;#1000
    wr_e_p = 0;
    rd_e_n = 0;#1000 
    #100 $finish;
end

endmodule
