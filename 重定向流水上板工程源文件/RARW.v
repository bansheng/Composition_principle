`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 14:12:16
// Design Name: 
// Module Name: RARW
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


module RARW(choose_rw, RS, RT, RD, ext5, ext16, EXTU, sys, RW, RA, ext5or16);
input [1:0]choose_rw;
input [4:0]RS,RT,RD;
input [31:0]ext5,ext16;
input EXTU,sys;
output [4:0]RW, RA;
output [31:0]ext5or16;

wire [4:0]ra;

assign ra = (EXTU==1)? RT: RS;
assign RA = (sys ==1)? 5'b00010: ra;
assign RW = choose_rw==2? 5'b11111: (
			choose_rw==1? RD: RT);
assign ext5or16 = (EXTU==1)? ext5: ext16;
endmodule
