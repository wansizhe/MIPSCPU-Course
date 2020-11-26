`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/11 22:43:27
// Design Name: 
// Module Name: CPU31_tb
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


module CPU31_tb();
reg clk;
reg reset;
integer file_output;
integer counter=0;
cpu CPU(clk,reset);
initial
begin
    clk<=0;
    reset<=1;
    file_output=$fopen("result.txt");
    #30 reset<=0;
end
always 
begin
    #10
    clk<=~clk;
    if(clk==1'b0)
    begin
        if(counter==3000)
            $fclose(file_output);
        else
        begin
            counter<=counter+1;
            $fdisplay(file_output,"pc:%h",CPU31_tb.CPU.pc.out_addr); 
            $fdisplay(file_output,"instruction:%h",CPU31_tb.CPU.imem.instruction);
            $fdisplay(file_output,"regfiles0:%h",CPU31_tb.CPU.RF.data[0]);
            $fdisplay(file_output,"regfiles1:%h",CPU31_tb.CPU.RF.data[1]);
            $fdisplay(file_output,"regfiles2:%h",CPU31_tb.CPU.RF.data[2]);
            $fdisplay(file_output,"regfiles3:%h",CPU31_tb.CPU.RF.data[3]);
            $fdisplay(file_output,"regfiles4:%h",CPU31_tb.CPU.RF.data[4]);
            $fdisplay(file_output,"regfiles5:%h",CPU31_tb.CPU.RF.data[5]);
            $fdisplay(file_output,"regfiles6:%h",CPU31_tb.CPU.RF.data[6]);
            $fdisplay(file_output,"regfiles7:%h",CPU31_tb.CPU.RF.data[7]);
            $fdisplay(file_output,"regfiles8:%h",CPU31_tb.CPU.RF.data[8]);
            $fdisplay(file_output,"regfiles9:%h",CPU31_tb.CPU.RF.data[9]);
            $fdisplay(file_output,"regfiles10:%h",CPU31_tb.CPU.RF.data[10]);
            $fdisplay(file_output,"regfiles11:%h",CPU31_tb.CPU.RF.data[11]);
            $fdisplay(file_output,"regfiles12:%h",CPU31_tb.CPU.RF.data[12]);
            $fdisplay(file_output,"regfiles13:%h",CPU31_tb.CPU.RF.data[13]);
            $fdisplay(file_output,"regfiles14:%h",CPU31_tb.CPU.RF.data[14]);
            $fdisplay(file_output,"regfiles15:%h",CPU31_tb.CPU.RF.data[15]);
            $fdisplay(file_output,"regfiles16:%h",CPU31_tb.CPU.RF.data[16]);
            $fdisplay(file_output,"regfiles17:%h",CPU31_tb.CPU.RF.data[17]);
            $fdisplay(file_output,"regfiles18:%h",CPU31_tb.CPU.RF.data[18]);
            $fdisplay(file_output,"regfiles19:%h",CPU31_tb.CPU.RF.data[19]);
            $fdisplay(file_output,"regfiles20:%h",CPU31_tb.CPU.RF.data[20]);
            $fdisplay(file_output,"regfiles21:%h",CPU31_tb.CPU.RF.data[21]);
            $fdisplay(file_output,"regfiles22:%h",CPU31_tb.CPU.RF.data[22]);
            $fdisplay(file_output,"regfiles23:%h",CPU31_tb.CPU.RF.data[23]);
            $fdisplay(file_output,"regfiles24:%h",CPU31_tb.CPU.RF.data[24]);
            $fdisplay(file_output,"regfiles25:%h",CPU31_tb.CPU.RF.data[25]);
            $fdisplay(file_output,"regfiles26:%h",CPU31_tb.CPU.RF.data[26]);
            $fdisplay(file_output,"regfiles27:%h",CPU31_tb.CPU.RF.data[27]);
            $fdisplay(file_output,"regfiles28:%h",CPU31_tb.CPU.RF.data[28]);
            $fdisplay(file_output,"regfiles29:%h",CPU31_tb.CPU.RF.data[29]);
            $fdisplay(file_output,"regfiles30:%h",CPU31_tb.CPU.RF.data[30]);
            $fdisplay(file_output,"regfiles31:%h",CPU31_tb.CPU.RF.data[31]);
        end
    end
end
endmodule
