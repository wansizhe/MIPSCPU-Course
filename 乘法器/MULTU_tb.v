`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/03/08 19:48:38
// Design Name: 
// Module Name: MULT_tb
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


module MULTU_tb(

    );
    reg [31:0] a;
    reg [31:0] b;
    wire [63:0] z;
    reg clk;
    reg reset;
    integer i;
    
    MULTU inst (.clk(clk),.reset(reset),.a(a),.b(b),.z(z));
    initial
    begin
    clk=0;
    #5;
    for(i=0;i<=1000;i=i+1)
    begin
       clk=~clk; 
       #5;
    end
    end
    
    initial
    begin
        reset=1;
        #10 reset=0;
    end
    
    initial
    begin
        a=32'b11100110000100000100000010000100;
    end
    
    initial
    begin
        b=32'b11100110010101000110000010100100;
    end
endmodule
