`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 21:55:50
// Design Name: 
// Module Name: EXtoMEM
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


module EXtoMEM(clk, run, clear,
WE, Byte, WE_DM, set, sys, lower,
data_in_re_choose,RW,PC, result, RFD2, LO,
WE_out, Byte_out, WE_DM_out, set_out, sys_out, lower_out,
data_in_re_choose_out,RW_out,PC_out, result_out, RFD2_out, LO_out
    );
input clk, run, clear;
input WE, Byte, WE_DM, set, sys, lower;
input [1:0]data_in_re_choose;
input [4:0]RW;
input [31:0]PC, result, RFD2, LO;
output WE_out, Byte_out, WE_DM_out, set_out, sys_out, lower_out;
output [1:0]data_in_re_choose_out;
output [4:0]RW_out;
output [31:0]PC_out, result_out, RFD2_out, LO_out;

wire enable;
assign enable=run;

REG r23(clk, enable, clear, WE, WE_out);
REG r24(clk, enable, clear, Byte, Byte_out);
REG r25(clk, enable, clear, WE_DM, WE_DM_out);
REG r26(clk, enable, clear, set, set_out);
REG r27(clk, enable, clear, sys, sys_out);
REG r28(clk, enable, clear, lower, lower_out);
REG2 r29(clk, enable, clear, data_in_re_choose, data_in_re_choose_out);
REG5 r30(clk, enable, clear, RW, RW_out);
REG32 r31(clk, enable, clear, PC, PC_out);
REG32 r32(clk, enable, clear, result, result_out);
REG32 r33(clk, enable, clear, RFD2, RFD2_out);
REG32 r34(clk, enable, clear, LO, LO_out);


endmodule
