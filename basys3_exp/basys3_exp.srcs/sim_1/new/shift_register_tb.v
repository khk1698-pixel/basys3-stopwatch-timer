`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/26 11:42:39
// Design Name: 
// Module Name: shift_register_tb
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


module shift_register_SISO_tb( );

reg D, clk;
wire Q;
reg [3:0] Data;

shift_register_SISO DUT(.D(D), .clk(clk), .reset_n(1), .Q(Q));

initial begin
    D = 0;
    clk = 0;
    Data = 4'b1101;
end

initial begin
    #100 clk=1;
    #100 D = Data[0];
    #10 clk = 0;
    #10 clk = 1;
    #10 D = Data[1];
    #100 clk=1;
    #100 D = Data[1];
    #10 clk = 0;
    #10 clk = 1;
    #10 D = Data[2];
    #100 clk=1;
    #100 D = Data[2];
    #10 clk = 0;
    #10 clk = 1;
    #10 D = Data[3];
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #100 $finish;
end

endmodule


module shift_register_SIPO_tb( );

reg D, clk;
wire [3:0] Q;
reg [3:0] Data;
reg rd_e_n;

shift_register_SIPO DUT(.D(D), .clk(clk), .rd_e_n(rd_e_n), .Q(Q));

initial begin
    D = 0;
    clk = 0;
    rd_e_n = 0;
    Data = 4'b1101;
end

initial begin
    #100 clk=1;
    #100 D = Data[0];
    #10 clk = 0;
    #10 clk = 1;
    #10 D = Data[1];
    #10 clk = 0;
    #10 clk = 1;
    #10 D = Data[2];
    #10 clk = 0;
    #10 clk = 1;
    #10 D = Data[3];
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 rd_e_n = 1;
    #10 clk = 1;
    #10 clk = 0;
    #100 $finish;
end

endmodule

module shift_register_PISO_tb( );

reg [3:0]D;
reg clk;
wire Q;
reg [3:0] Data;
reg shift_load;

shift_register_PISO DUT(.D(D), .clk(clk), .shift_load(shift_load), .Q(Q));

initial begin
    D = 0;
    clk = 0;
    shift_load = 0;
    Data = 4'b1101;
end

initial begin
    D = Data;
    #100 clk=1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    shift_load= 1;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    D = 4'b0001; 
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0; 
    shift_load= 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    shift_load= 1;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #100 $finish;
end

endmodule


module shift_register_PIPO_tb( );

reg [3:0]D;
reg clk;
wire [3:0] Q;
reg [3:0] Data;
reg rd_e_n, wr_e_p;

shift_register_PIPO DUT(.D(D), .clk(clk), .rd_n(rd_e_n), .wr_p(wr_e_p), .Q(Q));

initial begin
    D = 0;
    clk = 0;
    Data = 4'b1101;
    rd_e_n = 0;
    wr_e_p = 0;
end

initial begin
    D = Data;
    wr_e_p = 0;
    rd_e_n = 1;
    #100 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    wr_e_p = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    rd_e_n = 0; 
    #10 clk = 0; 
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    wr_e_p = 0;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    rd_e_n = 1; 
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    #10 clk = 1;
    #10 clk = 0;
    rd_e_n = 0; 
    #100 $finish;
end

endmodule