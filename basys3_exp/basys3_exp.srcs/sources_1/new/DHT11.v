`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/02 11:42:14
// Design Name: 
// Module Name: DHT11
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


module DHT11(
    input clk,
    input reset_n,
    output reg [7:0] humidity,
    output reg [7:0] temperature,
    inout dht11_data,
    output reg [7:0] led
    );
    
    wire clk_usec;
    
    parameter S_IDLE        = 3'b000;
    parameter S_LOW_10ms    = 3'b001;
    parameter S_HIGH_20us   = 3'b010;
    parameter S_LOW_80us    = 3'b011;
    parameter S_HIGH_80us   = 3'b100;
    parameter S_READ_DATA   = 3'b101;
    
    parameter S_WAIT_PEDGE = 3'b000;
    parameter S_WAIT_NEDGE = 3'b001;
    
    reg [21:0] count_usec;
    reg count_usec_e = 0;
    reg [2:0] state = S_IDLE;
    reg dht_buffer;
    reg [2:0] next_state = S_IDLE;
    reg [2:0] read_state = S_WAIT_PEDGE;
    reg [39:0] temp_data;
    reg [5:0] data_count = 0;
    
    wire dht_nedge, dht_pedge;
    
    assign dht11_data = dht_buffer;
    
    clock_usec usec_clk(.clk(clk), .reset_n(1), .clk_usec(clk_usec));
    
    always @(negedge clk_usec or negedge reset_n)begin
        if(!reset_n) count_usec = 0;
        else if (count_usec_e) count_usec = count_usec +1;
        else count_usec = 0;
    end
    
    always @(negedge clk_usec or negedge reset_n) begin
        if(!reset_n) state = S_IDLE;
        else state = next_state;
    end
    
    always @(negedge clk_usec or negedge reset_n) begin
        if(!reset_n) begin
            count_usec_e = 0;
        end
        else begin
            case(state)
                S_IDLE : begin
                    count_usec_e = 1;
                    if(count_usec < 22'd3000000)begin
                        dht_buffer = 1'bz;
                        count_usec_e = 1;
                        led[0] = 1;                        
                    end
                    else begin
                        next_state = S_LOW_10ms;
                        count_usec_e = 0;
                        led = 0;
                    end
                end
                S_LOW_10ms : begin
                    led[1] = 1;
                    if(count_usec < 19999)begin
                        count_usec_e = 1;
                        dht_buffer = 0;
                    end
                    else begin
                        count_usec_e = 0;
                        next_state = S_HIGH_20us;
                        dht_buffer = 1'bz;
                    end
                end
                S_HIGH_20us : begin
                    led[2] = 1;
                    if (count_usec < 3)begin
                        dht_buffer = 1'bz;
                        count_usec_e = 1;
                    end
                    else if(count_usec < 40)begin
                        count_usec_e = 1;
                        dht_buffer = 1'bz;
                        if(dht_nedge) begin
                            next_state = S_LOW_80us;
                            count_usec_e = 0;
                        end
                        else  begin
                            next_state = S_HIGH_20us;
                            count_usec_e = 1;
                        end
                    end
                    else begin
                        next_state = S_IDLE;
                        count_usec_e = 0;
                    end
                end
                S_LOW_80us : begin
                    led[3] = 1;
//                    if (count_usec < 3)begin
//                        dht_buffer = 1'bz;
//                        count_usec_e = 1;
//                    end
//                    else
                        if(count_usec < 83) begin
                        count_usec_e = 1;
                        if(dht_pedge) begin
                            next_state = S_HIGH_80us;
                            count_usec_e = 0;
                        end
                        else begin
                            next_state = S_LOW_80us;
                            count_usec_e = 1;
                        end
                    end
                    else begin
                        next_state = S_IDLE;
                        count_usec_e = 0;
                    end
                end
                S_HIGH_80us : begin
                    led[4] = 1;
//                    if (count_usec < 3)begin
//                        dht_buffer = 1'bz;
//                        count_usec_e = 1;
//                    end
//                    else
                    if(count_usec < 100) begin
                        count_usec_e = 1;
                        if(dht_nedge) begin
                           next_state = S_READ_DATA;
                          count_usec_e = 0;
                        end
                        else begin
                            next_state = S_HIGH_80us;
                            count_usec_e = 1;
                        end
                    end
                    else begin
                        next_state = S_IDLE;
                        count_usec_e = 0;
                    end
                end
                S_READ_DATA : begin
                    led[5] = 1;
                    case (read_state)
                        S_WAIT_PEDGE : begin
                            if(dht_pedge) begin
                                read_state = S_WAIT_NEDGE;
                                count_usec_e = 1;
                            end
                            else begin
                                count_usec_e = 0;
                            end
                        end
                        S_WAIT_NEDGE : begin
                            if(dht_nedge)begin
                                data_count = data_count + 1;
                                read_state = S_WAIT_PEDGE;
                                if(count_usec < 50) begin
                                    temp_data = {temp_data[38:0], 1'b0};
                                end
                                else begin
                                    temp_data = {temp_data[38:0], 1'b1};
                                end
                            end
                            else begin
                                count_usec_e = 1;
                                read_state = S_WAIT_NEDGE;
                            end
                        end
                        default : read_state = S_WAIT_PEDGE;
		            endcase
                    if(data_count >= 40) begin
                        data_count = 0;
                        next_state = S_IDLE;  
                        if(temp_data[39:32] + temp_data[31:24] + temp_data[23:16] + temp_data[15:8] == temp_data[7:0]) begin
                            humidity = temp_data[39:32];
                            temperature = temp_data[23:16];
                        end
                    end
                end
                default : next_state = S_IDLE;
            endcase
        end
    end
    
    edge_detect ed(.clk(clk_usec), .cp_in(dht11_data), .reset_n(1), .p_edge(dht_pedge), .n_edge(dht_nedge));
    
endmodule
