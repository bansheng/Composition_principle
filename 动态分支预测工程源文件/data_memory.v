`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 09:48:48
// Design Name: 
// Module Name: wyz
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


module mem(clk, WE_DM, address1, address2, data, Dout, Dout2);
input clk,WE_DM;
input [9:0]address1,address2;
input [31:0]data;
output [31:0]Dout;
output [31:0]Dout2;

reg [31:0]memory[1023:0];

always @(negedge clk)
begin
    if(WE_DM == 1)
        memory[address1] <= data;
end

assign Dout = memory[address1];
assign Dout2 = memory[address2];

endmodule
