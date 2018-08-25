`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 16:05:40
// Design Name: 
// Module Name: systemout
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


module systemout(clk, RW, WE, result, sysout, notEqual);
input [4:0]RW;
input WE,clk;
input [31:0]result;
output [31:0]sysout;
output notEqual;

reg [31:0]re2, re4;

initial begin
	re2 <=0;
	re4 <=0;
end

always @(posedge clk) begin
	if(WE==1) 
	begin
		if(RW==2 ) re2<=result;
		if(RW==4) re4<=result;
	end
end

assign notEqual = (re2==34)? 0: 1;

assign sysout=re4;
	
endmodule
