`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 19:34:30
// Design Name: 
// Module Name: circle_count
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


module circle_count(clk, run, J, B, BS, sum, cj, cb, cbs);
input clk, run, J, B, BS;
output reg [15:0]sum, cj, cb, cbs;

wire run_edge;

DetecEdge d1(clk,run,run_edge);

initial begin
	sum<=0;
	cj<=0;
	cb<=0;
	cbs<=0;
end
always @(posedge clk) begin
	if(run==1) begin
		sum <= sum+1;
	end
	if(run_edge==1) sum<=sum+1;
	if(J==1) cj <= cj + 1;
	if(B==1) cb <= cb + 1;
	if(BS==1) cbs <= cbs + 1;
end
endmodule

module DetecEdge(clk,pulse,pos_pulse);
input clk,pulse;
output pos_pulse;      
reg pulse1,pulse2,pulse3;
always @(posedge clk)
begin
  pulse1 <= pulse;
  pulse2 <= pulse1;
  pulse3 <= pulse2;
end
assign pos_pulse = (pulse3)&(~pulse2);
endmodule
