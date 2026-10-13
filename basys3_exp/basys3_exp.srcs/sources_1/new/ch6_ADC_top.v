`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/04 11:51:11
// Design Name: 
// Module Name: ch6_ADC_top
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


module ch6_ADC_top(
    input vauxp6,
    input vauxn6,
    input clk,
    output [3:0] com_an,
    output [7:0] seg_7
    );
    
    reg [11:0] adc_value;
    wire [15:0] bcd;
    wire [4:0] channel_out;
    wire [15:0] do_out;
    wire  eoc_out;
    
    xadc_wiz_0 adc_ch6
          (
          .daddr_in({2'b00, channel_out}),            // Address bus for the dynamic reconfiguration port
          .dclk_in(clk),             // Clock input for the dynamic reconfiguration port
          .den_in(eoc_out),              // Enable Signal for the dynamic reconfiguration port
//          di_in,               // Input data bus for the dynamic reconfiguration port
//          dwe_in,              // Write Enable for the dynamic reconfiguration port
          .reset_in(1'b0),            // Reset signal for the System Monitor control logic
          .vauxp6(vauxp6),              // Auxiliary channel 6
          .vauxn6(vauxn6),
//          busy_out,            // ADC Busy signal
          .channel_out(channel_out),         // Channel Selection Outputs
          .do_out(do_out),              // Output data bus for dynamic reconfiguration port
//          drdy_out,            // Data ready signal for the dynamic reconfiguration port
          .eoc_out(eoc_out)             // End of Conversion Signal
//          eos_out,             // End of Sequence Signal
//          alarm_out,           // OR'ed output of all the Alarms    
//          vp_in,               // Dedicated Analog Input Pair
//          vn_in
            );
            
//    assign adc_value = eoc_out ? do_out[15:4] : adc_value;
    
    always @(posedge eoc_out)begin
        adc_value = do_out [15:6];
    end
    
    bin_to_dec btd_temper(.bin(adc_value), .bcd(bcd));

    FND_4digit_switcher fnd(
    .value_1(bcd[3:0]),
    .value_10(bcd[7:4]),
    .value_100(bcd[11:8]), 
    .value_1000(bcd[15:12]),
    .clk(clk), .com_an (com_an), .seg_7(seg_7));
    
    
    
endmodule
