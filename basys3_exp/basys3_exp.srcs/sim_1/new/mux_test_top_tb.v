`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/19 10:41:25
// Design Name: 
// Module Name: mux_test_top_tb
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


module mux_test_top_tb( );

    reg clk_100MHz, clk_50MHz, clk_25MHz, clk_12500kHz, clk_6250kHz, clk_3125kHz, clk_1562kHz, clk_781kHz;
    reg [2:0] S_mux;
    reg [1:0] S_demux;
    wire [3:0] F;
    
mux_test_top DUT(
    .D({clk_100MHz, clk_50MHz, clk_25MHz, clk_12500kHz, clk_6250kHz, clk_3125kHz, clk_1562kHz, clk_781kHz}),
    .S_mux(S_mux),
    .S_demux(S_demux),
    .F(F)
    );
    
    initial begin
        clk_100MHz = 0;
        clk_50MHz = 0;
        clk_25MHz = 0;
        clk_12500kHz = 0;
        clk_6250kHz = 0;
        clk_3125kHz = 0;
        clk_1562kHz = 0;
        clk_781kHz = 0;
        S_mux = 0;
        S_demux = 0;
    end
    
    always #5 clk_100MHz = ~clk_100MHz;
    always #10 clk_50MHz = ~clk_50MHz;
    always #20 clk_25MHz = ~clk_25MHz;
    always #40 clk_12500kHz = ~clk_12500kHz;
    always #80 clk_6250kHz = ~clk_6250kHz;
    always #160 clk_3125kHz = ~clk_3125kHz;
    always #320 clk_1562kHz = ~clk_1562kHz;
    always #640 clk_781kHz = ~clk_781kHz;
    
    initial begin
        #10000
        S_mux = 3'b001;
        S_demux = 2'b01;
        #10000
        S_mux = 3'b010;
        S_demux = 2'b11;
        #10000
        S_mux = 3'b011;
        S_demux = 2'b11;
        #10000
        S_mux = 3'b100;
        S_demux = 2'b00;
        #10000
        S_mux = 3'b101;
        S_demux = 2'b01;
        #10000
        S_mux = 3'b110;
        S_demux = 2'b11;
        #10000
        S_mux = 3'b111;
        S_demux = 2'b10;
        #10000
        $finish;
    end
    
endmodule
