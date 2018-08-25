`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 11:20:19
// Design Name: 
// Module Name: MUX_2
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


module MUX_2(IN1, IN2, choice, OUT);
input [31:0]IN1;
input [31:0]IN2;
input choice;
output [31:0] OUT;

assign OUT= (choice==0)? IN1: IN2;
endmodule


module MUX_4(IN1, IN2, IN3, IN4, choice, OUT);
input [31:0]IN1;
input [31:0]IN2;
input [31:0]IN3;
input [31:0]IN4;
input [1:0]choice;
output [31:0]OUT;

assign OUT = (choice==0)? IN1:
			 (choice==1)? IN2:
			 (choice==2)? IN3: IN4;
endmodule


// module MUX_5_32(IN1, IN2, IN3, IN4, IN5, choice, OUT);
// input [31:0]IN1;
// input [31:0]IN2;
// input [31:0]IN3;
// input [31:0]IN4;
// input [31:0]IN5;
// input [2:0]choice;
// output [31:0]OUT;

// assign OUT = (choice==1)? IN2:
			 // (choice==2)? IN3:
			 // (choice==3)? IN4:
			 // (choice==4)? IN5: IN1;
		
// endmodule

module MUX_8_32(IN1, IN2, IN3, IN4, IN5, IN6, IN7, IN8, choice, OUT);
input [31:0]IN1;
input [31:0]IN2;
input [31:0]IN3;
input [31:0]IN4;
input [31:0]IN5;
input [31:0]IN6;
input [31:0]IN7;
input [31:0]IN8;
input [2:0]choice;
output [31:0]OUT;

assign OUT = (choice==1)? IN2:
			 (choice==2)? IN3:
			 (choice==3)? IN4:
			 (choice==4)? IN5:
			 (choice==5)? IN6: 
			 (choice==6)? IN7:
			 (choice==7)? IN8: IN1;
		
endmodule

module MUX_4_8(IN1, IN2, IN3, IN4, choice, OUT);
input [7:0]IN1;
input [7:0]IN2;
input [7:0]IN3;
input [7:0]IN4;
input [1:0]choice;
output [7:0]OUT;

assign OUT = (choice==0)? IN1:
			 (choice==1)? IN2:
			 (choice==2)? IN3: IN4;
endmodule

