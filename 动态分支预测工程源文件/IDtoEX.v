`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 21:55:31
// Design Name: 
// Module Name: IDtoEX
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


module IDtoEX(clk, run, bubble, clear_u, 
LO, result, data_in_re,
Byte, WE_DM, set, sys, WE_LO, J, JR, B, WE,LD,M,prediect_bs1,
choose_data_in_re, op_compare, alu_src,
ex5or16, extu16, RFD1, RFD2,PC,
imme,alu_op,RW,redirection,
Byte_out, WE_DM_out, set_out, sys_out, WE_LO_out, J_out, JR_out, B_out, WE_out,LD_out,M_out,prediect_bs2,
choose_data_in_re_out, op_compar_out, alu_src_out,
ex5or16_out, extu16_out, RFD1_out, RFD2_out,PC_out,
imme_out,alu_op_out,RW_out,redirection_out);
input clk, run, bubble, clear_u;
input [31:0]LO, result, data_in_re;
input Byte, WE_DM, set, sys, WE_LO, J, JR, B, WE,LD,M,prediect_bs1;//9
input [1:0]choose_data_in_re, op_compare, alu_src;//3
input [31:0]ex5or16, extu16, RFD1, RFD2, PC;//5
input [27:0]imme;
input [3:0]alu_op;
input [4:0]RW;
input [5:0]redirection;
output Byte_out, WE_DM_out, set_out, sys_out, WE_LO_out, J_out, JR_out, B_out, WE_out,LD_out,M_out,prediect_bs2;
output [1:0]choose_data_in_re_out, op_compar_out, alu_src_out;
output [31:0]ex5or16_out, extu16_out, RFD1_out, RFD2_out, PC_out;
output [27:0]imme_out;
output [3:0]alu_op_out;
output [4:0]RW_out;
output [5:0]redirection_out;



wire [31:0]RFD1_mid1, RFD1_mid2, RFD1_mid3;
wire [31:0]RFD2_mid1, RFD2_mid2, RFD2_mid3;
wire enable, clear;
assign enable=run;
assign clear = clear_u|bubble;

REG r3(clk, enable, clear, Byte, Byte_out);
REG r4(clk, enable, clear, WE_DM, WE_DM_out);
REG r5(clk, enable, clear, set, set_out);
REG r6(clk, enable, clear, sys, sys_out);
REG r7(clk, enable, clear, WE_LO, WE_LO_out);
REG r8(clk, enable, clear, J, J_out);
REG r9(clk, enable, clear, JR, JR_out);
REG r10(clk, enable, clear, B, B_out);
REG r11(clk, enable, clear, WE, WE_out);
REG r51(clk, enable, clear, M, M_out);
REG r52(clk, enable, clear, LD, LD_out);
REG2 r12(clk, enable, clear, choose_data_in_re, choose_data_in_re_out);
REG2 r13(clk, enable, clear, op_compare, op_compar_out);
REG2 r14(clk, enable, clear, alu_src, alu_src_out);
REG4 r15(clk, enable, clear, alu_op, alu_op_out);
REG5 r16(clk, enable, clear, RW, RW_out);
REG6 r17(clk, enable, clear, redirection, redirection_out);
REG28 r18(clk, enable, clear, imme, imme_out);
REG32 r19(clk, enable, clear, ex5or16, ex5or16_out);
REG32 r20(clk, enable, clear, extu16, extu16_out);
REG32 r21(clk, enable, clear, RFD1, RFD1_mid1);
REG32 r22(clk, enable, clear, RFD2, RFD2_mid1);
REG32 r50(clk, enable, clear, PC, PC_out);
REG r65(clk, enable, clear, prediect_bs1, prediect_bs2);


MUX_2 m10(RFD1_mid1, data_in_re, redirection_out[2], RFD1_mid2);
MUX_2 m11(RFD1_mid2, result, redirection_out[0], RFD1_mid3);
MUX_2 m12(RFD1_mid3, LO, redirection_out[4], RFD1_out);
MUX_2 m13(RFD2_mid1, data_in_re, redirection_out[3], RFD2_mid2);
MUX_2 m14(RFD2_mid2, result, redirection_out[1], RFD2_mid3);
MUX_2 m15(RFD2_mid3, LO, redirection_out[5], RFD2_out);


endmodule
