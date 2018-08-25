`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 11:02:22
// Design Name: 
// Module Name: clk_adjust
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

module clk_adjust(CLK,adjust,clk_clk);
input CLK,adjust;
output reg clk_clk;
wire clk_M;
wire clk_N;

initial begin clk_clk<=0;end

divider  a0(CLK,clk_M,clk_N);

always @(posedge CLK) begin   
	case(adjust)
		0:clk_clk<=clk_M;
		1:clk_clk<=clk_N;
	endcase
end
endmodule

module divider(CLK,clk_M,clk_N);//��Ƶ
input CLK;                      // ϵͳʱ��
output reg clk_M,clk_N;                   // ��Ƶ���ʱ��
parameter M = 250_0000;      // 40Hz��ʱ��,N=fclk/fclk_N
parameter N = 2;      // 50MHz��ʱ��,N=fclk/fclk_N
reg [31:0] counter;
reg [31:0] counter2;   
initial begin
clk_M<=0;counter<=0;clk_N<=0;counter2<=0;
end       
always @(posedge CLK)  begin    // ʱ�������� 
      if(counter==M/2-1)
      begin  
      clk_M<=~clk_M;
      counter<=0;  
      end
      else   counter<=counter+1;    // ����ʵ��
      
      if(counter2==N/2-1)
      begin  
      clk_N<=~clk_N;
      counter2<=0;  
      end
      else   counter2<=counter2+1;    // ����ʵ��
end     
endmodule