`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 21:53:56
// Design Name: 
// Module Name: IFtoID
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


module IFtoID(clk, run, bubble, clear, PC_in, instr_in, prediect_bs0, PC_out, instr_out, prediect_bs1);
input clk, run, bubble, clear;
input [31:0]PC_in, instr_in;
input prediect_bs0;
output [31:0]PC_out, instr_out;
output prediect_bs1;

wire enable;

assign enable=run&(~bubble);

REG32 r1(clk, enable, clear, PC_in, PC_out);
REG32 r2(clk, enable, clear, instr_in, instr_out);
REG r60(clk, enable, clear, prediect_bs0, prediect_bs1);


endmodule
