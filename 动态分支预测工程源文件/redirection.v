`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/19 17:04:11
// Design Name: 
// Module Name: redirection
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


module redirection(RA, RB, RW1, RW2, LD2, M2, WE1, WE2, bubble, dire);
	input [4:0]RA, RB, RW1, RW2;
	input LD2, M2, WE1, WE2;
	output bubble;
	output [5:0]dire;
	// wire a1, a2, b1, b2, am, bm;
	wire anez, bnez, ae1, be1, ae2, be2;
	

	assign anez= (RA==0)? 0: 1;
	assign bnez= (RB==0)? 0: 1;
	assign ae1= RA==RW1? 1: 0;
	assign ae2= RA==RW2? 1: 0;
	assign be1= RB==RW1? 1: 0;
	assign be2= RB==RW2? 1: 0;

	assign dire[0] = ae1&WE1&anez;
	assign dire[1] = be1&WE1&bnez;
	assign dire[2] = ae2&WE2&anez;
	assign dire[3] = be2&WE2&bnez;
	assign dire[4] = ae1&WE1&M2&anez;
	assign dire[5] = be1&WE1&M2&bnez;

	assign bubble=LD2&(dire[0]|dire[1]);
	

endmodule
