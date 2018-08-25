`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/21 11:19:41
// Design Name: 
// Module Name: update_cache
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


module update_cache(clk, addr1, addr2, addr3, B, J, JorBS,
v1,v2,v3,v4,v5,v6,v7,v8,
A1,A2,A3,A4,A5,A6,A7,A8,B1,B2,B3,B4,B5,B6,B7,B8,
s1,s2,s3,s4,s5,s6,s7,s8
);
//现在指令的内�?
input [31:0]addr1;
input [31:0]addr2, addr3; //用于更新替换
input J, B, JorBS;
input clk;

output v1,v2,v3,v4,v5,v6,v7,v8;
output [31:0]A1,A2,A3,A4,A5,A6,A7,A8,B1,B2,B3,B4,B5,B6,B7,B8;
output [1:0]s1,s2,s3,s4,s5,s6,s7,s8;
// output [2:0]L1,L2,L3,L4,L5,L6,L7,L8;
//cache内容
wire [7:0]nvalid;
wire [31:0]nADDR1[7:0];
wire [31:0]nADDR2[7:0];
wire [1:0]nstate[7:0];
wire [2:0]nLRU[7:0]; //自己维护替换

reg [7:0]pvalid;
reg [31:0]pADDR1[7:0];
reg [31:0]pADDR2[7:0];
reg [1:0]pstate[7:0];
reg [2:0]pLRU[7:0];

wire [7:0]equal;//比较�?
wire [2:0]index[7:0]; //每个运算器的下标
wire BorJ;// 跳转
wire hit; //命中
wire [2:0]hitlru;//命中者优先级
reg [2:0]hitnum; //命中者下�?
reg [3:0]validnum; //有效表项数目

assign {v1,v2,v3,v4,v5,v6,v7,v8} = pvalid;
assign A1=pADDR1[0];
assign A2=pADDR1[1];
assign A3=pADDR1[2];
assign A4=pADDR1[3];
assign A5=pADDR1[4];
assign A6=pADDR1[5];
assign A7=pADDR1[6];
assign A8=pADDR1[7];

assign B1=pADDR2[0];
assign B2=pADDR2[1];
assign B3=pADDR2[2];
assign B4=pADDR2[3];
assign B5=pADDR2[4];
assign B6=pADDR2[5];
assign B7=pADDR2[6];
assign B8=pADDR2[7];

assign s1=pstate[0];
assign s2=pstate[1];
assign s3=pstate[2];
assign s4=pstate[3];
assign s5=pstate[4];
assign s6=pstate[5];
assign s7=pstate[6];
assign s8=pstate[7];

// assign L1=pLRU[0];
// assign L2=pLRU[1];
// assign L3=pLRU[2];
// assign L4=pLRU[3];
// assign L5=pLRU[4];
// assign L6=pLRU[5];
// assign L7=pLRU[6];
// assign L8=pLRU[7];


assign BorJ=B|J;

always @(*) begin
	case(pvalid)
		8'h00: validnum<=0;
		8'h01: validnum<=1;
		8'h03: validnum<=2;
		8'h07: validnum<=3;
		8'h0f: validnum<=4;
		8'h1f: validnum<=5;
		8'h3f: validnum<=6;
		8'h7f: validnum<=7;
		8'hff: validnum<=8;
	endcase
end

para_compare p0(pvalid[0], pADDR1[0], addr1, BorJ, equal[0]);
para_compare p1(pvalid[1], pADDR1[1], addr1, BorJ, equal[1]);
para_compare p2(pvalid[2], pADDR1[2], addr1, BorJ, equal[2]);
para_compare p3(pvalid[3], pADDR1[3], addr1, BorJ, equal[3]);
para_compare p4(pvalid[4], pADDR1[4], addr1, BorJ, equal[4]);
para_compare p5(pvalid[5], pADDR1[5], addr1, BorJ, equal[5]);
para_compare p6(pvalid[6], pADDR1[6], addr1, BorJ, equal[6]);
para_compare p7(pvalid[7], pADDR1[7], addr1, BorJ, equal[7]);

assign hit=equal[0]|equal[1]|equal[2]|equal[3]|equal[4]|equal[5]|equal[6]|equal[7];

always @(*)begin
	case(equal)
	8'b10000000: hitnum<=7;
	8'b01000000: hitnum<=6;
	8'b00100000: hitnum<=5;
	8'b00010000: hitnum<=4;
	8'b00001000: hitnum<=3;
	8'b00000100: hitnum<=2;
	8'b00000010: hitnum<=1;
	8'b00000001: hitnum<=0;
	default: hitnum<=0;
	endcase
end
	
assign hitlru= pLRU[hitnum];

update_state up1(BorJ, JorBS, hit, hitlru, validnum, 0,
addr1, addr2, addr3, B,
pvalid[0], pADDR1[0], pADDR2[0], pstate[0], pLRU[0], 
nvalid[0], nADDR1[0], nADDR2[0], nstate[0], nLRU[0]);
update_state up2(BorJ, JorBS, hit, hitlru, validnum, 1,
addr1, addr2, addr3, B,
pvalid[1], pADDR1[1], pADDR2[1], pstate[1], pLRU[1], 
nvalid[1], nADDR1[1], nADDR2[1], nstate[1], nLRU[1]);
update_state up3(BorJ, JorBS, hit, hitlru, validnum, 2,
addr1, addr2, addr3, B,
pvalid[2], pADDR1[2], pADDR2[2], pstate[2], pLRU[2], 
nvalid[2], nADDR1[2], nADDR2[2], nstate[2], nLRU[2]);
update_state up4(BorJ, JorBS, hit, hitlru, validnum, 3,
addr1, addr2, addr3, B,
pvalid[3], pADDR1[3], pADDR2[3], pstate[3], pLRU[3], 
nvalid[3], nADDR1[3], nADDR2[3], nstate[3], nLRU[3]);
update_state up5(BorJ, JorBS, hit, hitlru, validnum, 4,
addr1, addr2, addr3, B,
pvalid[4], pADDR1[4], pADDR2[4], pstate[4], pLRU[4], 
nvalid[4], nADDR1[4], nADDR2[4], nstate[4], nLRU[4]);
update_state up6(BorJ, JorBS, hit, hitlru, validnum, 5,
addr1, addr2, addr3, B,
pvalid[5], pADDR1[5], pADDR2[5], pstate[5], pLRU[5], 
nvalid[5], nADDR1[5], nADDR2[5], nstate[5], nLRU[5]);
update_state up7(BorJ, JorBS, hit, hitlru, validnum, 6,
addr1, addr2, addr3, B,
pvalid[6], pADDR1[6], pADDR2[6], pstate[6], pLRU[6], 
nvalid[6], nADDR1[6], nADDR2[6], nstate[6], nLRU[6]);
update_state up8(BorJ, JorBS, hit, hitlru, validnum, 7,
addr1, addr2, addr3, B,
pvalid[7], pADDR1[7], pADDR2[7], pstate[7], pLRU[7], 
nvalid[7], nADDR1[7], nADDR2[7], nstate[7], nLRU[7]);


always @(posedge clk)begin
	pvalid <= nvalid;
	pstate[0]<=nstate[0];
	pstate[1]<=nstate[1];
	pstate[2]<=nstate[2];
	pstate[3]<=nstate[3];
	pstate[4]<=nstate[4];
	pstate[5]<=nstate[5];
	pstate[6]<=nstate[6];
	pstate[7]<=nstate[7];
	
	pADDR1[0]<=nADDR1[0];
	pADDR1[1]<=nADDR1[1];
	pADDR1[2]<=nADDR1[2];
	pADDR1[3]<=nADDR1[3];
	pADDR1[4]<=nADDR1[4];
	pADDR1[5]<=nADDR1[5];
	pADDR1[6]<=nADDR1[6];
	pADDR1[7]<=nADDR1[7];
	
	pADDR2[0]<=nADDR2[0];
	pADDR2[1]<=nADDR2[1];
	pADDR2[2]<=nADDR2[2];
	pADDR2[3]<=nADDR2[3];
	pADDR2[4]<=nADDR2[4];
	pADDR2[5]<=nADDR2[5];
	pADDR2[6]<=nADDR2[6];
	pADDR2[7]<=nADDR2[7];
	
	pLRU[0]<=nLRU[0];
	pLRU[1]<=nLRU[1];
	pLRU[2]<=nLRU[2];
	pLRU[3]<=nLRU[3];
	pLRU[4]<=nLRU[4];
	pLRU[5]<=nLRU[5];
	pLRU[6]<=nLRU[6];
	pLRU[7]<=nLRU[7];
	
end

endmodule


//比较
module para_compare(pvalid, paddr, address, BorJ, equal);
	input pvalid;
	input [31:0]paddr;
	input [31:0]address;
	input BorJ;
	output equal;
	assign equal= ((paddr==address)&&(pvalid==1)&&(BorJ==1))? 1: 0;
endmodule


module update_state(BorJ, JorBS, hit, hitlru, validnum, index,
address1, address2, address3, B,
pvalid, paddr1, paddr2, pstate, plru, 
nvalid, naddr1, naddr2, nstate, nlru);
	input BorJ, JorBS, hit;
	input [3:0]validnum;
	input [2:0]index;
	input [2:0]hitlru;
	input [31:0]address1, address2, address3;
	input B;
	input pvalid;
	input [31:0]paddr1, paddr2;
	input [1:0]pstate;
	input [2:0]plru;
	output reg nvalid;
	output reg[31:0]naddr1, naddr2;
	output reg[1:0]nstate;
	output reg [2:0]nlru;
	
	always @(*)begin
		naddr1<=paddr1;
		naddr2<=paddr2;
		nvalid<=pvalid;
		nstate<=pstate;
		nlru<=plru;
		if(BorJ==1)begin
			if(hit==1) //命中
			begin
				if(hitlru > plru) //比它小的需要加
					nlru <= plru+1;
				else if(hitlru == plru)
				begin
					if(JorBS==1) //命中跳转
					begin
						// if(pstate<3) nstate<=pstate+1;
						// else nstate<=pstate;
						case(pstate)
							2'b00: nstate<=1;
							2'b01: nstate<=3;
							2'b10: nstate<=3;
							2'b11: nstate<=3;
						endcase
					end
					else //命中未跳�?
					begin
						case(pstate)
							2'b00: nstate<=0;
							2'b01: nstate<=0;
							2'b10: nstate<=0;
							2'b11: nstate<=2;
						endcase
					end
					nlru <= 0;
				end
			end
			else //未命�?
			begin
				if((validnum<8)) //未满
				begin 
					if(index==validnum[2:0]) //当前空置
					begin
						nvalid<=1;
						naddr1<=address1;
						if(B==0) naddr2<=address2;
						else naddr2<=address3;
						nlru<=0;
						if(JorBS) nstate<=2; //预测跳转
						else nstate<=1; //预测不跳�?
					end
					else if(index<validnum[2:0])
						nlru <= plru+1;
				end	
				else //已经满了
				begin
					if(plru==7) //被置�?
					begin
						nvalid<=1;
						naddr1<=address1;
						if(B==0) naddr2<=address2;
						else naddr2<=address3;
						nlru<=0;
						if(JorBS) nstate<=2; //预测跳转
						else nstate<=1; //预测不跳�?
					end
					else begin
						nlru <= plru+1;
					end
				end
			end
		end
		
	end
	

endmodule










