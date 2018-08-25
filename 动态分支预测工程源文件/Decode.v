`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 21:17:07
// Design Name: 
// Module Name: Decode
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


module Decode(instr,op,rs,rt,rd,func , ext5, ext16, extu16, imm28);

input [31:0]instr;
output [5:0]op;
output [4:0]rs;
output [4:0]rt;
output [4:0]rd;
output [5:0]func;
output [31:0]ext5, ext16, extu16;
output [27:0]imm28;


assign op=instr[31:26];
assign rs=instr[25:21];
assign rt=instr[20:16];
assign rd=instr[15:11];
assign func=instr[5:0];
unsigned_5to32 un1(instr[10:6], ext5);
signed_16to32 si1(instr[15:0], ext16);
unsigned_16to32 un2(instr[15:0], extu16);
assign imm28 = {instr[25:0],2'b0};

endmodule
