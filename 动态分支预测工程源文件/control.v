`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 11:34:08
// Design Name: 
// Module Name: control
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


module control(OP,FUNC,WE,choose_in_re,EXTU,choose_rw,alu_src,
ALUOP,WE_DM,WE_LO,J,jr,B,OP_compare,Byte,set,sys,LD,M);
input [5:0]OP;             //输入OP
input [5:0]FUNC;          //输入FUNC

//input [1:0]state;         //输入状态

output WE;
output [1:0]choose_in_re;
output EXTU;
output [1:0]choose_rw;
output [1:0]alu_src;
output [3:0]ALUOP;
output WE_DM;
output WE_LO;
output J;
output jr;
output B;
output [1:0]OP_compare;
output Byte;
output set;
output sys;
output LD;
output M;

reg ADD,ADDU,AND,SLL,SRA,SRL,SUB,OR,NOR,SLT,SLTU,JR,syscall;
reg ADDI,ADDIU,ANDI,ORI,LW,SW,BEQ,BNE,SLTI,JUMP,JAL;
reg DIVU, MFLO, BLEZ, LB;

//是否需要给寄存器赋初值?
initial
begin
	ADD = 0;
	ADDU = 0;
	AND = 0;
	SLL = 0;
	SRA = 0;
	SRL = 0;
	SUB = 0;
	OR = 0;
	NOR = 0;
	SLT = 0;
	SLTU = 0;
	JR = 0;
	syscall = 0;
	ADDI = 0;
	ADDIU = 0;
	ANDI = 0;
	ORI = 0;
	LW = 0;
	SW = 0;
	BEQ = 0;
	BNE = 0;
	SLTI = 0;
	JUMP = 0;
	JAL = 0;
	DIVU=0; 
	MFLO=0;
	BLEZ=0;
	LB=0;
end


always @(*)
begin       
	ADD = 0;
	ADDU = 0;
	AND = 0;
	SLL = 0;
	SRA = 0;
	SRL = 0;
	SUB = 0;
	OR = 0;
	NOR = 0;
	SLT = 0;
	SLTU = 0;
	JR = 0;
	syscall = 0;
	ADDI = 0;
	ADDIU = 0;
	ANDI = 0;
	ORI = 0;
	LW = 0;
	SW = 0;
	BEQ = 0;
	BNE = 0;
	SLTI = 0;
	JUMP = 0;
	JAL = 0;
	
	DIVU=0; 
	MFLO=0;
	BLEZ=0;
	LB=0;
    
	case(OP)
	6'b000000:
	begin
		case(FUNC)
		6'b100000:ADD = 1;
		6'b100001:ADDU = 1;
		6'b100100:AND = 1;
		6'b000000:SLL = 1;
		6'b000011:SRA = 1;
		6'b000010:SRL = 1;
		6'b100010:SUB = 1;
		6'b100101:OR = 1;
		6'b100111:NOR = 1;
		6'b101010:SLT = 1;
		6'b101011:SLTU = 1;
		6'b001000:JR = 1;
		6'b001100:syscall = 1;
		6'b011011:DIVU = 1;
		6'b010010:MFLO = 1;
		
		endcase
	end
	6'b100000:LB = 1;
	6'b000110:BLEZ = 1;
	6'b001000:ADDI = 1;
	6'b001001:ADDIU = 1;
	6'b001100:ANDI = 1;
	6'b001101:ORI = 1;
	6'b100011:LW = 1;
	6'b101011:SW = 1;
	6'b000100:BEQ = 1;
	6'b000101:BNE = 1;
	6'b001010:SLTI = 1;
	6'b000010:JUMP = 1;
	6'b000011:JAL = 1;
	
	endcase
end

// WE,choose_in_re,EXTU,choose_rw,alu_src,
// ALUOP,WE_DM,WE_LO,J,jr,B,OP_compare,Byte,set,sys,LD,M

assign WE = JAL|ADD|ADDU|AND|SLL|SRL|SRA|SUB|OR|NOR|SLT|ADDI|ADDIU|SLTI|SLTU|ANDI|ORI|LB|LW|MFLO;
//assign STOP = (number = 32'Ha)&syscall;
assign choose_in_re = {JAL|MFLO,LW|LB|MFLO};
assign EXTU = SLL|SRL|SRA;
assign choose_rw = {JAL,ADD|ADDU|AND|SLL|SRA|SRL|SUB|OR|NOR|SLT|MFLO|SLTU};
assign alu_src = {ORI|ADDIU|BLEZ|ANDI, ADDU|ADD|AND|OR|SUB|NOR|BEQ|BNE|SLT|SLTU|DIVU|BLEZ};
assign ALUOP[0] = ADD|ADDI|ADDU|ADDIU|AND|ANDI|SRA|LW|SW|BEQ|SLT|SLTI|LB|BLEZ;
assign ALUOP[1] = AND|ANDI|SRL|SUB|NOR|BNE|SLT|SLTI|BLEZ;
assign ALUOP[2] = ADD|ADDI|ADDU|ADDIU|AND|ANDI|SUB|LW|SW|BEQ|BNE|SLTU|DIVU|LB;
assign ALUOP[3] = OR|ORI|NOR|BEQ|BNE|SLTU|SLT|SLTI|BLEZ;
assign WE_DM = SW;
assign WE_LO = DIVU;
assign J = JR|JUMP|JAL;
assign jr = JR;
assign B = BEQ|BNE|BLEZ;
assign OP_compare = {SLTI|SLT|SLTU|BLEZ, BLEZ|BNE};
assign Byte = LB;
assign set = SLTI|SLT|SLTU;
assign sys = syscall;
assign LD = LW|LB;
assign M = MFLO;
endmodule
