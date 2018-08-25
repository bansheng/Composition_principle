`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 10:06:49
// Design Name: 
// Module Name: register
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


// 5位addr和32位data用来查看寄存器文件中寄存器文件的值
module register_group(clk, WE, rA, rB, rW, addr,  Din, RFD1, RFD2 ,data);

input  [4:0]  rA, rB, rW, addr;
input  [31:0] Din;
input clk, WE;
output [31:0] RFD1, RFD2, data;


reg [31:0] rf[31:0];//32位32个


//initial begin
//    for (i=0; i<32; i=i+1)
//       rf[i] = 0;
//end

always @(negedge clk) begin //下降沿写入
	if (WE)
		rf[rW] <= Din;
   // `ifdef DEBUG
      // $display("R[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", 0, rf[1], rf[2], rf[3], rf[4], rf[5], rf[6], rf[7]);
      // $display("R[08-15]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[8], rf[9], rf[10], rf[11], rf[12], rf[13], rf[14], rf[15]);
      // $display("R[16-23]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[16], rf[17], rf[18], rf[19], rf[20], rf[21], rf[22], rf[23]);
      // $display("R[24-31]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X", rf[24], rf[25], rf[26], rf[27], rf[28], rf[29], rf[30], rf[31]);
   // `endif
end // end always

assign RFD1 = (rA == 0) ? 0 : rf[rA];
assign RFD2 = (rB == 0) ? 0 : rf[rB];
assign data = (addr == 0) ? 0 : rf[addr];
endmodule
