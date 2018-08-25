`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 14:10:35
// Design Name: 
// Module Name: display
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


module display(Select1, circle, PC, regdata, memdata, data_to_show);

input [1:0] Select1; //ä¸¤ä?
input [31:0]circle, PC, regdata, memdata;

output [31:0]data_to_show;

//jinzhi_16to10 j1(cycle1,Cycle1);
//jinzhi_16to10 j2(cycle2,Cycle2);
//jinzhi_16to10 j3(cycle3,Cycle3);
//jinzhi_16to10 j4(cycle4,Cycle4);

assign data_to_show = (Select1 == 0)?circle:
                     (Select1 == 1)?PC:
                     (Select1 == 2)?regdata: memdata;
					 
                     
endmodule
