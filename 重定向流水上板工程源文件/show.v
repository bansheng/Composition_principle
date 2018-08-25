`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 16:02:36
// Design Name: 
// Module Name: show
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


module show(clk,data,SEG,AN);
input [31:0] data;
input clk;
output [7:0]SEG;
output reg [7:0]AN;
wire [2:0] _pos;
reg [3:0] data_to_show;
wire [3:0] _data_to_show;
clk_divider c1(clk,_pos);
    
    always @(posedge clk) begin
        case(_pos)
            3'b000 : begin AN <= 8'b11111110; data_to_show<=data[3:0]; end
            3'b001 : begin AN <= 8'b11111101; data_to_show<=data[7:4]; end
            3'b010 : begin AN <= 8'b11111011; data_to_show<=data[11:8]; end
            3'b011 : begin AN <= 8'b11110111; data_to_show<=data[15:12]; end
            3'b100 : begin AN <= 8'b11101111; data_to_show<=data[19:16]; end
            3'b101 : begin AN <= 8'b11011111; data_to_show<=data[23:20]; end
            3'b110 : begin AN <= 8'b10111111; data_to_show<=data[27:24]; end
            3'b111 : begin AN <= 8'b01111111; data_to_show<=data[31:28]; end
        endcase
    end
    
    assign _data_to_show = data_to_show;
    decode_show d2(_data_to_show, SEG);
endmodule
