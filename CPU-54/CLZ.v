`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/05/29 14:19:27
// Design Name: 
// Module Name: CLZ
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


module CLZ(
input [31:0] data,
output [31:0] count
);
wire[31:0]count1,count2,count3,count4,count5;
wire[15:0]temp1;
wire[7:0]temp2;
wire[3:0]temp3;
wire[2:0]temp4;
wire temp5;
assign count1=data[31:16]>0?0:16;
assign temp1=data[31:16]>0?data[31:16]:data[15:0];
assign count2=temp1[15:8]>0?count1:count1+8;
assign temp2=temp1[15:8]>0?temp1[15:8]:temp1[7:0];
assign count3=temp2[7:4]>0?count2:count2+4;
assign temp3=temp2[7:4]>0?temp2[7:4]:temp2[3:0];
assign count4=temp3[3:2]>0?count3:count3+2;
assign temp4=temp3[3:2]>0?temp3[3:2]:temp3[1:0];
assign count5=temp4[1]>0?count4:count4+1;
assign temp5=temp4[1]>0?temp4[1]:temp4[0];
assign count=temp5>0?count5:count5+1;
endmodule
