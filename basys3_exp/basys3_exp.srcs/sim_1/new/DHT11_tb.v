`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/02 15:44:11
// Design Name: 
// Module Name: DHT11_tb
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


module DHT11_tb( );

    reg clk, reset_n;
    wire [7:0] humidity, temperature;
    tri1 dht11_data;
    
    reg wr = 0;
    reg din;
    
    integer i;
    
    parameter [7:0] humi_value = 8'd80;
    parameter [7:0] temp_value = 8'd25;
    parameter [7:0] checksum = humi_value + temp_value;
    parameter [39:0] data = {humi_value, {8{1'b0}}, temp_value, {8{1'b0}}, checksum};
    
    assign dht11_data = (wr == 1) ? din : 1'bz;
    
    DHT11 DUT(
.clk(clk), .reset_n(reset_n),
 .humidity(humidity),
     .temperature(temperature),
 .dht11_data(dht11_data)
);
     
     initial begin
        clk = 0;
        reset_n = 0;
    end
    
    always #5 clk = ~clk;
    
    initial begin
        #100 reset_n = 0; wr = 0;
        #100 reset_n = 1; wr = 0;
        wait(!dht11_data);
        wait(dht11_data) begin
            din = 1; wr = 1;
        end
        #1000 din = 1;
        #4000 din = 0;
        #4000 din = 1;
        #4000 din = 0;
        for (i=0; i<40; i=i+1)begin
            if(data[39-i]) begin
                #2000 din = 1;
                #70000 din = 0;
            end
            else begin
                #2000 din = 1;
                #26000 din = 0;
            end
        end
        #10000
        $finish;
    end
    
endmodule
