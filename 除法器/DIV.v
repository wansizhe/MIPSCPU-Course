`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/03/19 14:18:31
// Design Name: 
// Module Name: DIV
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
module DIVU(
    input [31:0] dividend,
    input [31:0] divisor,
    input start,
    input clock,
    input reset,
    output [31:0] q,
    output [31:0] r,
    output reg busy
    );
    wire ready;
    reg [4:0] count;
    reg [31:0] reg_q;
    reg [31:0] reg_r;
    reg [31:0] reg_b;
    reg busy2,r_sign;
    assign ready=~busy&busy2;
    wire [32:0] sub_add=r_sign?({reg_r,q[31]}+{1'b0,reg_b}):({reg_r,q[31]}-{1'b0,reg_b});
    assign r=r_sign?reg_r+reg_b:reg_r;
    assign q=reg_q;
    always @(posedge clock or posedge reset)
    begin
        if(reset==1)
        begin
            count<=5'b0;
            busy<=0;
            busy2<=0;
        end
        else
        begin
            busy2<=busy;
            if(start)
            begin
                reg_r<=32'b0;
                r_sign<=0;
                reg_q<=dividend;
                reg_b<=divisor;
                count<=5'b0;
                busy<=1'b1;
            end
            else if(busy)
            begin
                reg_r<=sub_add[31:0];
                r_sign<=sub_add[32];
                reg_q<={reg_q[30:0],~sub_add[32]};
                count<=count+5'b1;
                if(count==5'b11111)
                    busy<=0;
            end
        end
    end
endmodule

module DIV(
    input [31:0] dividend,
    input [31:0] divisor,
    input clock,
    input reset,
    input start,
    output [31:0] q,
    output [31:0] r,
    output busy
    );
    wire [31:0] abs_dividend=dividend[31]?~dividend+1:dividend;
    wire [31:0] abs_divisor=divisor[31]?~divisor+1:divisor;
    wire [31:0] abs_q;
    wire [31:0] abs_r;
    DIVU divu(.dividend(abs_dividend),.divisor(abs_divisor),.clock(clock),.reset(reset),.start(start),.q(abs_q),.r(abs_r),.busy(busy));
    assign q=(dividend[31]==divisor[31])?abs_q:~abs_q+1;
    assign r=dividend[31]?~abs_r+1:abs_r;
endmodule
