`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/04/17 13:27:45
// Design Name: 
// Module Name: half_adder
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


module half_adder(
    input A,
    input B,
    output S,
    output C
    );
    
    xor u1(S, A, B);
    and u2(C, A ,B);
    
    
endmodule

module half_adder_b(
    input A,
    input B,
    output reg S,
    output reg Cout
    );
    
    always @(A or B) begin
        case ({A, B})
            2'b00 : {Cout, S} = 2'b00;
            2'b01 : {Cout, S} = 2'b01;
            2'b10 : {Cout, S} = 2'b10;
            2'b11 : {Cout, S} = 2'b11;
        endcase
    end
    
endmodule

module half_adder_b1(
    input A,
    input B,
    output reg S,
    output reg Cout
    );
    
    always @(A or B) begin
        S = A ^ B;
        Cout = A & B;
    end
    
endmodule

module half_adder_d(
    input A,
    input B,
    output wire S,
    output wire Cout
    );
    
    assign S = A ^ B;
    assign Cout = A & B;
    
endmodule