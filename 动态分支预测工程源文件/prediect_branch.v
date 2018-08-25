`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/21 16:45:04
// Design Name: 
// Module Name: prediect_branch
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
// wire JR, JUMP, JAL, BEQ, BNE, BLEZ, BorJ;


// assign op=instr[31:26];
// assign func=instr[5:0];
// signed_16to32 si1(instr[15:0], ext16);
// assign imm28 = {instr[25:0],2'b0};

// always @(*)
// begin       
	// JR = 0;
	// BEQ = 0;
	// BNE = 0;
	// JUMP = 0;
	// JAL = 0;
	// BLEZ=0;
	// case(op)
	// 6'b000000: if(func==6'b001000) JR = 1;
	// 6'b000110: BLEZ = 1;
	// 6'b000100: BEQ = 1;
	// 6'b000101: BNE = 1;
	// 6'b000010: JUMP = 1;
	// 6'b000011: JAL = 1;
	// endcase
// end
// assign BorJ = JR|JUMP|JAL|BEQ|BNE|BLEZ;
// 
//////////////////////////////////////////////////////////////////////////////////


module prediect_branch(PC, instr,
	v1,v2,v3,v4,v5,v6,v7,v8,
	A1,A2,A3,A4,A5,A6,A7,A8,B1,B2,B3,B4,B5,B6,B7,B8,
	s1,s2,s3,s4,s5,s6,s7,s8,
	PC_out, prediect_branch);
input [31:0]PC,instr;
input v1,v2,v3,v4,v5,v6,v7,v8;
input [31:0]A1,A2,A3,A4,A5,A6,A7,A8,B1,B2,B3,B4,B5,B6,B7,B8;
input [1:0]s1,s2,s3,s4,s5,s6,s7,s8;
output reg[31:0]PC_out;
output reg prediect_branch;

wire J;
wire [31:0]label;
assign J = (instr[31:26]==6'b000010)? 1: 0;
assign label= {4'h0,instr[25:0],2'b0};

wire [7:0]equal;

pc_compare pc1(v1, A1, PC, equal[0]); 
pc_compare pc2(v2, A2, PC, equal[1]); 
pc_compare pc3(v3, A3, PC, equal[2]); 
pc_compare pc4(v4, A4, PC, equal[3]); 
pc_compare pc5(v5, A5, PC, equal[4]); 
pc_compare pc6(v6, A6, PC, equal[5]); 
pc_compare pc7(v7, A7, PC, equal[6]); 
pc_compare pc8(v8, A8, PC, equal[7]); 

always @(*)begin
	if(J==1) begin
		PC_out<=label;
		prediect_branch<=1;
	end
	else begin
		case(equal)
		8'b10000000: begin
			if(s8>=2)begin
				PC_out<=B8;
				prediect_branch<=1;
			end
			else begin
				PC_out<=PC+32'h4;
				prediect_branch<=0;
			end
			end
		8'b01000000: begin
			if(s7>=2)begin
				PC_out<=B7;
				prediect_branch<=1;
			end
			else begin
				PC_out<=PC+32'h4;
				prediect_branch<=0;
			end
			end
		8'b00100000: begin
			if(s6>=2)begin
				PC_out<=B6;
				prediect_branch<=1;
			end
			else begin
				PC_out<=PC+32'h4;
				prediect_branch<=0;
			end
			end
		8'b00010000: begin
			if(s5>=2)begin
				PC_out<=B5;
				prediect_branch<=1;
			end
			else begin
				PC_out<=PC+32'h4;
				prediect_branch<=0;
			end
			end
		8'b00001000: begin
			if(s4>=2)begin
				PC_out<=B4;
				prediect_branch<=1;
			end
			else begin
				PC_out<=PC+32'h4;
				prediect_branch<=0;
			end
			end
		8'b00000100: begin
			if(s3>=2)begin
				PC_out<=B3;
				prediect_branch<=1;
			end
			else begin
				PC_out<=PC+32'h4;
				prediect_branch<=0;
			end
			end
		8'b00000010: begin
			if(s2>=2)begin
				PC_out<=B2;
				prediect_branch<=1;
			end
			else begin
				PC_out<=PC+32'h4;
				prediect_branch<=0;
			end
			end
		8'b00000001: begin
			if(s1>=2)begin
				PC_out<=B1;
				prediect_branch<=1;
			end
			else begin
				PC_out<=PC+32'h4;
				prediect_branch<=0;
			end
			end
		default: 
			begin
				PC_out<=PC+32'h4;
				prediect_branch<=0;
			end
		endcase
	end
//	prediect_branch<=0;
end

endmodule





module pc_compare(pvalid, paddr, address, equal);
	input pvalid;
	input [31:0]paddr;
	input [31:0]address;
	output equal;
	assign equal= ((paddr==address)&&(pvalid==1))? 1: 0;
endmodule
