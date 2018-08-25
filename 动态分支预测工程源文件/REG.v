`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 19:28:44
// Design Name: 
// Module Name: REG
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


module REG(clk, enable, clear, data_in, data_out);
input clk, enable, clear;
input data_in;
output reg data_out;
initial data_out<=0;
always @(posedge clk)begin
	if(clear) data_out<=0;
	
	else if(enable) data_out<=data_in;
end
endmodule

module REG2(clk, enable, clear, data_in, data_out);
input clk, enable, clear;
input [1:0]data_in;
output reg [1:0]data_out;
initial data_out<=0;
always @(posedge clk)begin
	if(clear) data_out<=0;
	
	else if(enable) data_out<=data_in;
end
endmodule

module REG4(clk, enable, clear, data_in, data_out);
input clk, enable, clear;
input [3:0]data_in;
output reg [3:0]data_out;
initial data_out<=0;
always @(posedge clk)begin
	if(clear) data_out<=0;
	
	else if(enable) data_out<=data_in;
end
endmodule

module REG5(clk, enable, clear, data_in, data_out);
input clk, enable, clear;
input [4:0]data_in;
output reg[4:0]data_out;
initial data_out<=0;
always @(posedge clk)begin
	if(clear) data_out<=0;
	
	else if(enable) data_out<=data_in;
end
endmodule

module REG6(clk, enable, clear, data_in, data_out);
input clk, enable, clear;
input [5:0]data_in;
output reg[5:0]data_out;
initial data_out<=0;
always @(posedge clk)begin
	if(clear) data_out<=0;
	
	else if(enable) data_out<=data_in;
end
endmodule

module REG28(clk, enable, clear, data_in, data_out);
input clk, enable, clear;
input [27:0]data_in;
output reg[27:0]data_out;
initial data_out<=0;
always @(posedge clk)begin
	if(clear) data_out<=0;
	
	else if(enable) data_out<=data_in;
end
endmodule

module REG32(clk, enable, clear, data_in, data_out);
input clk, enable, clear;
input [31:0]data_in;
output reg[31:0]data_out;
initial data_out<=0;
always @(posedge clk)begin
	if(clear) data_out<=0;
	else if(enable) data_out<=data_in;
end
endmodule



