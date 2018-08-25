`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/09/18 21:06:37
// Design Name: 
// Module Name: clk_divider
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


module clk_divider(clk,pos);
input clk;
output reg [2:0] pos;
parameter N = 200_000;
reg [31:0] counter;
initial begin
pos = 0;
end

always@(posedge clk)
begin

    if(counter==N/2 -1) begin
		counter <= 0;
		if(pos == 7) pos <= 0;
		else pos <= pos + 1;
    end
    else begin
		counter <= counter + 1;
    end
end
endmodule
