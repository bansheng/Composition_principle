`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 18:43:37
// Design Name: 
// Module Name: CP
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

//±È½ÏÄ£¿é
module compare(clk, RFD1, ext5or16, RFD2, extu16, alu_src,
op_compare, alu_op, sys, EN_LO, CP_result, result, LO, lower, Y);
	input clk;
	input [31:0]RFD1, ext5or16, RFD2, extu16;
	input [1:0]alu_src, op_compare;
	input [3:0]alu_op;
	input sys, EN_LO;
	output CP_result;
	output [31:0]result,LO;
	output lower;
	output [31:0]Y;
	
	wire equal;
	wire [31:0] Y1,result2;
	reg [31:0]LO1;
	
	MUX_4 m21(ext5or16, RFD2, extu16, 32'h0, alu_src, Y1);
	MUX_2 m22(Y1, 32'h22, sys, Y);
	
	
	alu a100(alu_op,RFD1,Y,equal,result,result2);
	
	always @(posedge clk) begin
		if(EN_LO==1) LO1<=result;
	end
	
	assign lower = result[0];
	
	assign CP_result = (op_compare==0)? equal :(
					   (op_compare==1)? ~equal:(
					   (op_compare==2)? lower : lower|equal));
					   
	assign LO = LO1;
endmodule
