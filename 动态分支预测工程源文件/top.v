`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 15:48:49
// Design Name: 
// Module Name: top
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


module top(cp,c_clk,CLK,RST,run,pause,Continue,adjust,select,light,slt_light,slt_light2,slt_light3,slt_ok_light,AN,SEG);
//data_t,
//state_t,
//clk_t,
//NPC_t,PC_t,instruction_t,OP_t,FUNC_t, rs_t,rt_t,rd_t,shamt_t,
// imm_t,
// label_t,
// pc_plus4_t,
// s_t,EXTU_t,RB_t,RD_t,LD_t,WE_t,display_t,STOP_t,
// S_PC_t,W_t,RW_t,Y_t,RA_t,
// Din_t,REGA_t,REGB_t,
// rW_t,rA_t,rB_t,
// reg2_t,
//ALUOP_t,
// MUX1_t,MUX2_t,ALU_Y2_t,ALU_Y3_t,ALU_Y_t,
// alu_result_t,alu_result2_t,
//Dout_t,Dout2_t,total_t,nonj_t,ifj_t,ifjok_t,syscall_out_t/*AN,SEG*/);
  input cp,c_clk,CLK,RST,run,pause,Continue,adjust;
  input [13:0]select;
  output [7:0]SEG;
  output [7:0]AN;
  output light,slt_light,slt_ok_light,slt_light2,slt_light3;
//  output [31:0] data,Dout2,PC;
//  output [15:0] total,nonj,ifj,ifjok;

  wire [31:0] data;
  wire clk,clk_clk;
  wire [1:0] state;
  wire [31:0] NPC,PC;
  wire [31:0] instruction;
  wire [5:0] OP,FUNC;
  wire [4:0] rs,rt,rd,shamt;
  wire [15:0] imm1;
  wire [25:0] label;
  wire [31:0] pc_plus4;
  wire s,EXTU,RB,RD,LD,WE,display,STOP;
  wire [1:0] S_PC,W,RW,Y,RA;
  wire [31:0] Din,REGA,REGB;
  wire [4:0] rW,rA;
  wire [31:0] reg2;
  wire [3:0] ALUOP;
  wire [31:0] MUX1,MUX2,ALU_Y2,ALU_Y3,ALU_Y;
  wire [31:0] alu_result,alu_result2;
  wire equal,slt;
  wire [31:0] Dout,Dout2;
  wire [15:0] total,nonj,ifj,ifjok;
  wire [31:0] syscall_out,data_reg;
  
//  output [31:0] data_t;
//  output clk_t;
//  output [1:0] state_t;
//  output [31:0] NPC_t,PC_t;
//  output [31:0] instruction_t;
//  output [5:0] OP_t,FUNC_t;
//  output [4:0] rs_t,rt_t,rd_t,shamt_t;
//  output [15:0] imm_t;
//  output [25:0] label_t;
//  output [31:0] pc_plus4_t;
//  output s_t,EXTU_t,RB_t,RD_t,LD_t,WE_t,display_t,STOP_t;
//  output [1:0] S_PC_t,W_t,RW_t,Y_t,RA_t;
//  output [31:0] Din_t,REGA_t,REGB_t;
//  output [4:0] rW_t,rA_t,rB_t;
//  output [31:0] reg2_t;
//  output [3:0] ALUOP_t;
//  output [31:0] MUX1_t,MUX2_t,ALU_Y2_t,ALU_Y3_t,ALU_Y_t;
//  output [31:0] alu_result_t,alu_result2_t;
//  output [31:0] Dout_t,Dout2_t;
//  output [15:0] total_t,nonj_t,ifj_t,ifjok_t;
//  output [31:0] syscall_out_t;
  
  pc_register A0(CLK,RST,state,NPC,PC);
  IR A1(PC, instruction);
  decoder A2(instruction,OP,rs,rt,rd,shamt,FUNC,label,imm1);
  npc A3(NPC,pc_plus4,PC,label,imm1,alu_result,S_PC,REGA,s);
  
  control A4(OP,FUNC,reg2,state,s,WE,STOP,display,LD,RW,RD,EXTU,RA,Y,ALUOP,W,S_PC,light,slt);
  
  MUX_4_5 A5(rt, rd, 31, 0, RW, rW);
  MUX_4_5 A6(rs, rt, 4, 0, RA, rA);
  MUX_4 A7(alu_result, pc_plus4, Dout, 0, W, Din);
  register_group A8( rA, rt,select[13:9] , rW, Din, CLK, WE, REGA, REGB ,data_reg);
  
  signed_16to32 A9(imm1, ALU_Y2);
  unsigned_16to32 A10(imm1, MUX1);
  unsigned_5to32 A11(shamt, MUX2);
  MUX_2 A12(MUX1, MUX2,EXTU, ALU_Y3);
  MUX_4 A13(REGB, ALU_Y2, ALU_Y3, 0, Y, ALU_Y);
  alu A14(ALUOP,REGA,ALU_Y,equal,alu_result,alu_result2);
  
  register2 A15(Din,rW,CLK,RST,reg2);
  syscall A16(REGA,display,RST,clk,data);
  
  mem A17(alu_result[11:2],{6'b0,select[8:5]},REGB,CLK,RD,LD,Dout,Dout2);
//  mem(address1,address2,data,clk,RD,LD,Dout,Dout2);
  clk_count A18(S_PC,alu_result[0],STOP,state,CLK,RST,total,nonj,ifj,ifjok);
  
  display A19(select[1:0],select[4:2],data,Dout2,PC,total,nonj,ifj,ifjok,REGA,ALU_Y,Dout,data_reg,syscall_out);
  show A20(CLK,syscall_out,SEG,AN);
  clk_adjust A21(CLK,RST,adjust,STOP,run,pause,Continue,clk_clk,state);     //使用系统时钟，clk_clk为分频后的clk
  
  assign slt_light = slt;
  assign slt_ok_light = slt & alu_result[0];
  assign slt_light2 = ( instruction == 41173034) ? 1 : 0;
  assign slt_light3 = ( OP == 0 && FUNC == 42) ? 1 : 0 ; 
  assign clk = c_clk ? cp : clk_clk;
//  assign rB = rt;
//  assign data_t = data;
//  assign clk_t = clk;
//  assign state_t = state;
//  assign NPC_t = NPC;
//  assign PC_t = PC;
//  assign instruction_t = instruction;
//  assign OP_t = OP;
//  assign FUNC_t = FUNC;
//  assign rs_t =rs;
//  assign rt_t = rt;
//  assign rd_t =rd;
//  assign shamt_t = shamt;
//  assign imm_t = imm;
//  assign label_t = label;
//  assign pc_plus4_t = pc_plus4;
//  assign s_t = s;
//  assign EXTU_t = EXTU;
//  assign RB_t = RB;
//  assign RD_t = RD;
//  assign LD_t = LD;
//  assign WE_t = WE;
//  assign display_t = display;
//  assign STOP_t = STOP;
//  assign S_PC_t = S_PC;
//  assign W_t = W;
//  assign RW_t= RW;
//  assign Y_t = Y;
//  assign RA_t = RA;
//  assign Din_t = Din;
//  assign REGA_t = REGA;
//  assign REGB_t = REGB;
//  assign rW_t = rW;
//  assign rA_t = rA;
//  assign rB_t = rB;
//  assign reg2_t = reg2;
//  assign ALUOP_t = ALUOP;
//  assign MUX1_t = MUX1;
//  assign MUX2_t = MUX2;
//  assign ALU_Y2_t = ALU_Y2;
//  assign ALU_Y3_t = ALU_Y3;
//  assign ALU_Y_t = ALU_Y;
//  assign alu_result_t = alu_result;
//  assign alu_result2_t = alu_result2;
//  assign Dout_t = Dout;
//  assign Dout2_t = Dout2;
//  assign total_t = total;
//  assign nonj_t = nonj;
//  assign ifj_t = ifj;
//  assign ifjok_t = ifjok;
//  assign syscall_out_t = syscall_out;
endmodule
