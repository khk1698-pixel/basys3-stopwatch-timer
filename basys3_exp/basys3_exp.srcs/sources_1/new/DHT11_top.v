`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/03 13:05:19
// Design Name: 
// Module Name: DHT11_top
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


module DHT11_top(
    input clk,
    input btn,
    inout dht11_data,
    output [3:0] com_an,
    output [6:0] seg_7,
    output [7:0] led
    );
    
    wire [7:0] humidity, temperature;
    wire [15:0] bcd_humi, bcd_temper;
    wire reset_n;
    wire clk_160ns, clk_2560ns, clk_40us, debounced_btn;
    
    clock_divider cd_16(.clk(clk), .sel(3), .clk_out(clk_160ns));
    clock_divider cd_256(.clk(clk_160ns), .sel(3), .clk_out(clk_2560ns));
    clock_divider cd_40960(.clk(clk_2560ns), .sel(3), .clk_out(clk_40us));
    
    D_flip_flop_posedge off (.D(btn), .E(clk_40us), .Q(debounced_btn));
    
    assign reset_n = ~debounced_btn;
    
    DHT11 dht(
.clk(clk),
 .reset_n(reset_n),
     .humidity(humidity),
 .temperature(temperature),
 .dht11_data(dht11_data), .led(led)
);
  
    bin_to_dec btd_humi(.bin({4'd0, humidity}), .bcd(bcd_humi));
    bin_to_dec btd_temper(.bin({4'd0, temperature}), .bcd(bcd_temper));

    FND_4digit_switcher fnd(.value_1(bcd_temper[3:0]), .value_10(bcd_temper[7:4]), .value_100(bcd_humi[3:0]), .value_1000(bcd_humi[7:4]),
    .clk(clk), .com_an (com_an), .seg_7(seg_7));
    
endmodule
