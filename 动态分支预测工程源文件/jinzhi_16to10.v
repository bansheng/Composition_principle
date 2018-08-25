`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 11:39:56
// Design Name: 
// Module Name: jinzhi_16to10
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

//转换一个16位的数在数码管上显示出来
module turn(data,data_10);
input [15:0]data;
output reg [15:0] data_10;

always @(data) begin
	data_10[3:0] <= data[3:0];
	data_10[7:4] <= data[7:4];
	data_10[11:8] <= data[11:8];
	data_10[15:12] <= data[15:12];
	if(data_10[3:0] > 9) begin
		data_10[3:0] <= data_10[3:0] - 10;
		data_10[7:4] <= data_10[7:4] + 1;
	end
	if(data_10[7:4] > 9) begin
		data_10[7:4] <= data_10[7:4] - 10;
		data_10[11:8] <= data_10[11:8] + 1;
	end
	if(data_10[11:8] > 9) begin
		data_10[11:8] <= data_10[11:8] - 10;
		data_10[15:12] <= data_10[15:12] + 1;
	end
end

endmodule
