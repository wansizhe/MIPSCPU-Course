`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:14:04 11/24/2013 
// Design Name: 
// Module Name:    sccomp_dataflow 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module sccomp_dataflow(
input clk_in,
input reset,
input [15:0] sw,
output [7:0] o_seg,
output [7:0] o_sel
    ); 
	 
	 wire exc;
	 wire [31:0]status;
	 
wire [31:0]rdata;
wire [31:0]wdata;
wire IM_R,DM_CS,DM_R,DM_W;
wire [31:0]inst,pc,addr;
wire inta,intr;
wire clk;
wire [31:0]data_fmem;

wire [31:0]ip_in;
wire seg7_cs,switch_cs;

assign ip_in = pc-32'h00400000;

assign intr = 0;
clk_div #(3)cpu_clk(clk_in,clk);

/*地址译码*/
io_sel io_mem(addr, DM_CS, DM_W, DM_R, seg7_cs, switch_cs);

cpu sccpu(clk,reset,inst,rdata,pc,addr,wdata,IM_R,DM_CS,DM_R,DM_W,intr,inta);

/*指令存储器*/
imem imem(ip_in[12:2],inst);
//imemory im(pc,inst);

/*数据存储器*/
dmem scdmem(~clk,reset,DM_CS,DM_W,DM_R,addr-32'h10010000,wdata,data_fmem);

seg7x16 seg7(clk, reset, seg7_cs, wdata, o_seg, o_sel);

sw_mem_sel sw_mem(switch_cs, sw, data_fmem, rdata);

endmodule
