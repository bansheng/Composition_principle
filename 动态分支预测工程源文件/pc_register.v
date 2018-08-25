`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 10:00:32
// Design Name: 
// Module Name: pc_register
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


module pc_register(clk, RST, contin, sys, notequal, BandJ,
bubble ,PC_in1, PC_in2, PC, run);
input clk;
input RST, contin, sys, notequal, BandJ, bubble;
input [31:0]PC_in1, PC_in2;
output reg [31:0] PC;
output run;


initial PC <= 0;

assign run=contin|(~(sys&notequal));

always @(posedge clk) begin
	if(RST) PC<=0;//重置
	else
	begin
		if(run&(~bubble)) begin //使能打开
			if(BandJ==1) PC <= PC_in2;
			 else PC <= PC_in1;
//           else PC <= PC+32'h4;
		end
	end
end
	

endmodule