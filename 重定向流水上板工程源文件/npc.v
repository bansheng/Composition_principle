`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 11:02:36
// Design Name: 
// Module Name: npc
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


module npc(clk, PC, imme, RFD1, ext5or16, prediect_bs, B, J, JR, compare_result, BandJ, BS, PC_out,
v1,v2,v3,v4,v5,v6,v7,v8,
A1,A2,A3,A4,A5,A6,A7,A8,B1,B2,B3,B4,B5,B6,B7,B8,
s1,s2,s3,s4,s5,s6,s7,s8);
    input clk;
	input [31:0]PC;
	input [27:0]imme;
	input [31:0]RFD1;
	input [31:0]ext5or16;
	input B, J, JR, compare_result,prediect_bs;
	output BandJ, BS;
	output [31:0]PC_out;
	output v1,v2,v3,v4,v5,v6,v7,v8;
	output [31:0]A1,A2,A3,A4,A5,A6,A7,A8,B1,B2,B3,B4,B5,B6,B7,B8;
	output [1:0]s1,s2,s3,s4,s5,s6,s7,s8;
	// output [2:0]L1,L2,L3,L4,L5,L6,L7,L8;
	
	wire [31:0]pc_plus4,IMM,ext5or16plus, PC1, PC2, PC3;
	wire JorBS;
	
	
	assign BS = B&compare_result;
	assign pc_plus4=PC+32'h4;
	assign ext5or16plus = ext5or16<<2;
	assign IMM = {pc_plus4[31:28], imme};
	assign PC1 = ext5or16plus + pc_plus4;
	assign BandJ = ((J|BS)==prediect_bs)? 0: 1; //已经跳转的不�?
	assign JorBS = J|BS;
	
	MUX_2 m1(IMM, RFD1, JR, PC2);
	MUX_2 m2(pc_plus4, PC1, BS, PC3);
	MUX_2 m3(PC3, PC2, J, PC_out);
	update_cache up10(clk, PC, PC_out,PC1, B, J, JorBS, 
		v1,v2,v3,v4,v5,v6,v7,v8,
		A1,A2,A3,A4,A5,A6,A7,A8,B1,B2,B3,B4,B5,B6,B7,B8,
		s1,s2,s3,s4,s5,s6,s7,s8);
	
endmodule
