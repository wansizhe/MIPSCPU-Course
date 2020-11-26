`timescale 1ns / 1ps
module RegFile(
input RF_w,
input RF_clk,
input [4:0] rdc,
input [4:0] rtc,
input [4:0] rsc,
input [31:0] rd,
output [31:0] RS,
output [31:0] RT
);
reg [31:0] data [0:31];
initial
begin
    data[0]<=0;
    data[1]<=0;
    data[2]<=0;
    data[3]<=0;
    data[4]<=0;
    data[5]<=0;
    data[6]<=0;
    data[7]<=0;
    data[8]<=0;
    data[9]<=0;
    data[10]<=0;
    data[11]<=0;
    data[12]<=0;
    data[13]<=0;
    data[14]<=0;
    data[15]<=0;
    data[16]<=0;
    data[17]<=0;
    data[18]<=0;
    data[19]<=0;
    data[20]<=0;
    data[21]<=0;
    data[22]<=0;
    data[23]<=0;
    data[24]<=0;
    data[25]<=0;
    data[26]<=0;
    data[27]<=0;
    data[28]<=0;
    data[29]<=0;
    data[30]<=0;
    data[31]<=0;
end
always @(posedge RF_clk)
begin
    if(RF_w)
        if(rdc!=0)
            data[rdc]<=rd;
end
assign RS=data[rsc];
assign RT=data[rtc];
endmodule