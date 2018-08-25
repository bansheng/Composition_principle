`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/03/12 10:00:50
// Design Name: 
// Module Name: IR
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


module IR(PC, instruction);
input[31:0]PC;
output [31:0]instruction;
reg[31:0]Instruction[1023:0];

initial
begin
    $readmemh("F:/courses_studying/logisim/project/U201514658dyd_flow/U201514658dyd_flow.srcs/sources_1/benchmark.txt",Instruction);
end

assign instruction = Instruction[PC[11:2]];

endmodule
