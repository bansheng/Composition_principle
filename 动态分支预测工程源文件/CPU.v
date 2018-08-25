`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 10:35:21
// Design Name: 
// Module Name: CPU
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


module CPU(CLK, control_clk, cp, adjust, RST, contin, SW, BTH, AN, SEG, LED);
input CLK;//系统时钟输入
input control_clk; //时钟控制
input cp; //手动时钟
input adjust; //时钟调频
input RST, contin, BTH; //重置和继续执行按
input [6:0]SW; //选择显示数据 
output [7:0]AN,SEG;
output [10:0]LED;
// J, B, BS, BandJ, bubble, control_clk;


wire sys1,sys2,sys3,sys4;
wire [31:0]PC0,PC1,PC2,PC3,PC4;
wire run; //运行信号
wire [31:0]instruction0, instruction1;
wire [5:0]op, func;
wire [4:0]RS, RT, RD;
wire [31:0]ext5, ext16;
wire [31:0]extu1, extu2;
wire [31:0]ext1, ext2;
wire [27:0]imm28_1, imm28_2;
wire WE1, WE2, WE3, WE4;
wire [1:0]choose_in_re1,choose_in_re2,choose_in_re3, choose_in_re4;
wire EXTU;
wire [1:0]choose_rw;
wire [1:0]alu_src1, alu_src2;
wire [3:0]ALUOP1, ALUOP2;
wire WE_DM1, WE_DM2, WE_DM3;
wire WE_LO1, WE_LO2;
wire J1, J2, JR1, JR2, B1, B2;
wire [1:0]op_compare1, op_compare2;
wire Byte1, Byte2, Byte3, Byte4;
wire set1, set2, set3, set4;
wire LD1, M1, LD2, M2;
wire [4:0]RW1, RW2, RW3, RW4;
wire [4:0]RA;
wire bubble;
wire [5:0]dire1, dire2;
wire [31:0]RFD1_1, RFD1_2;
wire [31:0]RFD2_1, RFD2_2, RFD2_3;
wire [31:0]LO2, LO3, LO4;
wire [31:0]result2, result3, result4;
wire compare_result;
wire lower2, lower3, lower4;
wire BS;
wire [31:0]PC_predict, PC_next;
wire [31:0]memory3, memory4;
wire [1:0]sel;
wire [31:0]WE_data;
wire clk;
wire clk_clk; //分频时钟
wire [31:0]Y;


wire v1,v2,v3,v4,v5,v6,v7,v8;
wire [31:0]A1,A2,A3,A4,A5,A6,A7,A8,b1,b2,b3,b4,b5,b6,b7,b8;
wire [1:0]s1,s2,s3,s4,s5,s6,s7,s8;
wire prediect_bs0, prediect_bs1, prediect_bs2;
wire [31:0]addr1, addr2, state, valid;


wire clear1, clear2, clear3, clear4;
wire [31:0]regdata, memdata,sysout,PC_to_show, circle_to_show, data_to_show;
wire [31:0]data_to_show1, data_to_show2;
wire [15:0]circle_sum, circle_J, circle_B, circle_BS; //周期
assign clear1= RST|BandJ;
assign clear2= RST|BandJ;
assign clear3= RST;
assign clear4= RST;
assign LED[4:0]={J2,B2,BS,BandJ,bubble};

assign state={2'h0,s8,2'h0,s7,2'h0,s6,2'h0,s5,2'h0,s4,2'h0,s3,2'h0,s2,2'h0,s1};
assign valid={3'h0,v8,3'h0,v7,3'h0,v6,3'h0,v5,3'h0,v4,3'h0,v3,3'h0,v2,3'h0,v1};

clk_adjust top0(CLK,adjust,clk_clk);
assign clk = control_clk==1 ? cp : clk_clk;


pc_register top1(clk, RST, contin, sys4, notequal, BandJ, bubble ,PC_predict, PC_next, PC0, run);
prediect_branch top30(PC0,instruction0,
	v1,v2,v3,v4,v5,v6,v7,v8,
	A1,A2,A3,A4,A5,A6,A7,A8,b1,b2,b3,b4,b5,b6,b7,b8,
	s1,s2,s3,s4,s5,s6,s7,s8,
	PC_predict, prediect_bs0);
IR top2(PC0, instruction0);



IFtoID top3(clk, run, bubble, clear1, PC0, instruction0, prediect_bs0, PC1, instruction1, prediect_bs1);


Decode top4(instruction1,op,RS,RT,RD,func, ext5, ext16, extu1, imm28_1);
control top5(op,func,WE1,choose_in_re1,EXTU,choose_rw,alu_src1,ALUOP1,
	WE_DM1,WE_LO1,J1,JR1,B1,op_compare1,Byte1,set1,sys1,LD1,M1);
RARW top6(choose_rw, RS, RT, RD, ext5, ext16, EXTU, sys1, RW1, RA, ext1);
redirection top7(RA, RT, RW2, RW3, LD2, M2, WE2, WE3, bubble, dire1);
register_group top8(clk, WE4, RA, RT, RW4, SW[6:2],  WE_data, RFD1_1, RFD2_1 ,regdata); 
//留了读取寄存器的接口



IDtoEX top9(clk, run, bubble, clear2, 
	LO3, result3, WE_data,
	Byte1, WE_DM1, set1, sys1, WE_LO1, J1, JR1, B1, WE1,LD1,M1,prediect_bs1,
	choose_in_re1, op_compare1, alu_src1,
	ext1, extu1, RFD1_1, RFD2_1,PC1,
	imm28_1,ALUOP1,RW1,dire1,
	Byte2, WE_DM2, set2, sys2, WE_LO2, J2, JR2, B2, WE2,LD2,M2,prediect_bs2,
	choose_in_re2, op_compare2, alu_src2,
	ext2, extu2, RFD1_2, RFD2_2, PC2,
	imm28_2,ALUOP2,RW2,dire2);

assign LED[10:5]=dire2;//重定�????
compare top10(clk, RFD1_2, ext2, RFD2_2, extu2, alu_src2,
	op_compare2, ALUOP2, sys2, WE_LO2, compare_result, result2, LO2, lower2, Y );
npc top11(clk, PC2, imm28_2, RFD1_2, ext2, prediect_bs2, B2, J2, JR2, compare_result, BandJ, BS, PC_next ,
	v1,v2,v3,v4,v5,v6,v7,v8,
	A1,A2,A3,A4,A5,A6,A7,A8,b1,b2,b3,b4,b5,b6,b7,b8,
	s1,s2,s3,s4,s5,s6,s7,s8);


EXtoMEM top12(clk, run, clear3,
	WE2, Byte2, WE_DM2, set2, sys2, lower2,
	choose_in_re2,RW2,PC2, result2, RFD2_2, LO2,
	WE3, Byte3, WE_DM3, set3, sys3, lower3,
	choose_in_re3,RW3,PC3, result3, RFD2_3, LO3
		);

mem top13(clk, WE_DM3, result3[11:2], { 6'b0,SW[5:2]}, RFD2_3, memory3, memdata); //16个位�??????????
	
		

MEMtoRB top14(clk, run, clear4,
	WE3, Byte3, set3, sys3, lower3,
	result3[1:0], choose_in_re3,
	RW3, PC3, result3, LO3, memory3,
	WE4, Byte4, set4, sys4, lower4,
	sel, choose_in_re4,
	RW4, PC4, result4, LO4, memory4);


data_in_re top15(sel, choose_in_re4, result4, memory4, PC4, LO4, Byte4, lower4, set4, WE_data);
systemout top16(clk, RW4, WE4, result4, sysout, notequal);
circle_count top17(clk, run, J2, B2, BS, circle_sum, circle_J, circle_B, circle_BS);

MUX_8_32 top18(PC0, PC1, PC2, PC3, PC4,{RFD1_2[15:0], Y[15:0]}, RFD1_1, RFD2_1, SW[4:2], PC_to_show);
MUX_8_32 top19(sysout,{16'h0,circle_sum},{16'h0,circle_J},{16'h0,circle_B},{16'h0,circle_BS},{27'h0,RA},{27'h0,RT},{27'h0,RW1},SW[4:2],circle_to_show);   //alu_X, alu_Y     
MUX_8_32 top31(A1,A2,A3,A4,A5,A6,A7,A8, SW[4:2], addr1);
MUX_8_32 top35(b1,b2,b3,b4,b5,b6,b7,b8, SW[4:2], addr2);
display top20(SW[1:0], circle_to_show, PC_to_show, regdata, memdata, data_to_show1);
display top32(SW[1:0], addr1, addr2, valid, state, data_to_show2);
MUX_2 top33(data_to_show1, data_to_show2, BTH, data_to_show);
show top21(CLK, data_to_show, SEG, AN);


endmodule
