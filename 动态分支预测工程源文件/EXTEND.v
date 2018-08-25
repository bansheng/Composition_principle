`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 11:15:42
// Design Name: 
// Module Name: unsigned_5to32
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



module unsigned_5to32(IN, OUT);
input [4:0]IN;
output[31:0]OUT;
assign OUT = { {27'h0000},IN};
endmodule

module unsigned_16to32(IN, OUT);
input [15:0]IN;
output[31:0]OUT;
assign OUT = { {16'h0000},IN};
endmodule

module signed_16to32(IN, OUT);
input [15:0]IN;
output reg[31:0]OUT;
initial begin
    OUT <= 0;
    end
always @(IN)begin
    if(IN[15]==1'b1) OUT<= { {16'hffff},IN};
    else OUT<= { {16'h0000},IN};
    end
endmodule

module signed_8to32(IN, OUT);
input [7:0]IN;
output reg[31:0]OUT;
initial begin
    OUT <= 0;
    end
always @(IN)begin
    if(IN[7]==1'b1) OUT<= { {24'hffffff},IN};
    else OUT<= { {24'h0000},IN};
    end
endmodule