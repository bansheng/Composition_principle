`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 15:20:18
// Design Name: 
// Module Name: data_in_re
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


module data_in_re(sel, choose, result, data, pc, lo, Byte, lower, set, we_data);
input [1:0]sel,choose;
input [31:0]result, data, pc, lo;
input Byte, lower, set;
output [31:0]we_data;

wire [31:0]pc4, D1, DataB, D2; //
wire ss; //set成功
wire [7:0]dataB; //


MUX_4_8 m481(data[7:0], data[15:8], data[23:16], data[31:24], sel, dataB);
signed_8to32 s8(dataB, DataB);
MUX_2 m21(data, DataB, Byte, D1);
assign pc4 = pc + 32'h4;
assign ss = set&lower;

MUX_4 m41(result, D1, pc4, lo, choose, D2);
MUX_4 m22(D2,D2 ,32'h0, 32'h1, {set,lower}, we_data);

endmodule
