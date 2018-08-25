`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 21:56:20
// Design Name: 
// Module Name: MEMtoRB
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


module MEMtoRB(clk, run, clear,
WE, Byte, set, sys, lower,
sel, data_in_re_choose,
RW, PC, result, LO, data,
WE_out, Byte_out, set_out, sys_out, lower_out,
sel_out, data_in_re_choose_out,
RW_out, PC_out, result_out, LO_out, data_out);
input clk, run,clear;
input WE, Byte, set, sys, lower;
input [1:0]sel, data_in_re_choose;
input [4:0]RW;
input [31:0]PC, result, LO, data;
output WE_out, Byte_out, set_out, sys_out, lower_out;
output [1:0]sel_out, data_in_re_choose_out;
output [4:0]RW_out;
output [31:0]PC_out, result_out, LO_out, data_out;

wire enable;
assign enable=run;

REG r35(clk, enable, clear, WE, WE_out);
REG r36(clk, enable, clear, Byte, Byte_out);
REG r37(clk, enable, clear, set, set_out);
REG r38(clk, enable, clear, sys, sys_out);
REG r39(clk, enable, clear, lower, lower_out);
REG2 r40(clk, enable, clear, sel, sel_out);
REG2 r41(clk, enable, clear, data_in_re_choose, data_in_re_choose_out);
REG5 r42(clk, enable, clear, RW, RW_out);
REG32 r43(clk, enable, clear, PC, PC_out);
REG32 r44(clk, enable, clear, result, result_out);
REG32 r45(clk, enable, clear, LO, LO_out);
REG32 r46(clk, enable, clear, data, data_out);

endmodule
