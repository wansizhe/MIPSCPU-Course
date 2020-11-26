`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/06/02 16:44:25
// Design Name: 
// Module Name: cpu54_tb
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


module cpu54_tb();
    reg clk;
    reg reset;
    //wire [31:0] o_addr;
    wire [31:0] inst;
    //wire [15:0] rf28;
    integer file_output;
    integer counter=0;
    //integer i;
    CPU54_dataflow test(clk,reset,inst);
    initial
    begin
        clk<=0;
        reset<=1;
        file_output=$fopen("result.txt");
        #1 reset<=0;
    end
    always 
    begin
        #1;
        clk<=~clk;
        if(clk==1'b0)
        begin
            if(counter==3000)
                $fclose(file_output);
            else
            begin
                counter<=counter+1;
                $fdisplay(file_output,"pc:%h",cpu54_tb.test.imem_in); 
                //$fdisplay(file_output,"pc:%h",cpu54_tb.test.PC.out); 
                $fdisplay(file_output,"instr:%h",cpu54_tb.test.IMEM.instr);
                //$fdisplay(file_output,"mul_out:%h",cpu54_tb.test.mul_out);
                //$fdisplay(file_output,"m[13]:%h",cpu54_tb.test.m[13]);
                //$fdisplay(file_output,"m[17]:%h",cpu54_tb.test.m[17]);
                //$fdisplay(file_output,"instr:%h",cpu54_tb.test.IMEM.instr);
                //$fdisplay(file_output,"m11_1:%h",cpu54_tb.test.m11_1);
                //$fdisplay(file_output,"m[11]:%h",cpu54_tb.test.m[11]);
                //$fdisplay(file_output,"rs:%h",cpu54_tb.test.rs);
                //$fdisplay(file_output,"mfc0:%h",cpu54_tb.test.mfc0);
                //$fdisplay(file_output,"mtc0:%h",cpu54_tb.test.mtc0);
                //$fdisplay(file_output,"rt:%h",cpu54_tb.test.rt);
                //$fdisplay(file_output,"addr:%h",cpu54_tb.test.CP0.addr);
                //$fdisplay(file_output,"rdata:%h",cpu54_tb.test.CP0.rdata);
                //$fdisplay(file_output,"instr:%h",cpu54_tb.test.IMEM.instr);
                //$fdisplay(file_output,"m[13]:%h",cpu54_tb.test.m[13]);
                //$fdisplay(file_output,"m17_1:%h",cpu54_tb.test.m17_1);
                //$fdisplay(file_output,"m[17]:%h",cpu54_tb.test.m[17]);
                //$fdisplay(file_output,"m11_1:%h",cpu54_tb.test.m11_1);
                //$fdisplay(file_output,"m[11]:%h",cpu54_tb.test.m[11]);
                
                //$fdisplay(file_output,"m17_0:%h",cpu54_tb.test.m17_0);
                //$fdisplay(file_output,"m[17]:%h",cpu54_tb.test.m[17]);
                //$fdisplay(file_output,"m11_1:%h",cpu54_tb.test.m11_1);
                //$fdisplay(file_output,"m[11]:%h",cpu54_tb.test.m[11]);
                //$fdisplay(file_output,"m[19]:%h",cpu54_tb.test.m[19]);
                //$fdisplay(file_output,"m[20]:%h",cpu54_tb.test.m[20]);
                //$fdisplay(file_output,"Hi_in:%h",cpu54_tb.test.Hi_in);
                $fdisplay(file_output,"Hi:%h",cpu54_tb.test.HI.data);
               // $fdisplay(file_output,"Lo_in:%h",cpu54_tb.test.Lo_in);
                $fdisplay(file_output,"Lo:%h",cpu54_tb.test.LO.data);
                $fdisplay(file_output,"divu_out:%h",cpu54_tb.test.divu_out);
                $fdisplay(file_output,"m[15]:%h",cpu54_tb.test.m[15]);
                $fdisplay(file_output,"m[16]:%h",cpu54_tb.test.m[16]);
                $fdisplay(file_output,"m12_1:%h",cpu54_tb.test.m[16]);
                //$fdisplay(file_output,"Hi_ena:%h",cpu54_tb.test.hi_ena);
                //$fdisplay(file_output,"Lo_ena:%h",cpu54_tb.test.lo_ena);
                //$fdisplay(file_output,"Hi_we:%h",cpu54_tb.test.hi_we);
                //$fdisplay(file_output,"Lo_we:%h",cpu54_tb.test.lo_we);
                //$fdisplay(file_output,"Hi_out:%h",cpu54_tb.test.m22_1);
                //$fdisplay(file_output,"Lo_out:%h",cpu54_tb.test.m22_0);
                //$fdisplay(file_output,"m[22]:%h",cpu54_tb.test.m[22]);
                //$fdisplay(file_output,"m21_1:%h",cpu54_tb.test.m21_1);
                //$fdisplay(file_output,"m[21]:%h",cpu54_tb.test.m[21]);
                //$fdisplay(file_output,"m2_0:%h",cpu54_tb.test.m2_0);
                //$fdisplay(file_output,"m[2]:%h",cpu54_tb.test.m[2]);
                //$fdisplay(file_output,"m7_1:%h",cpu54_tb.test.m7_1);
                //$fdisplay(file_output,"m[7]:%h",cpu54_tb.test.m[7]);
                //$fdisplay(file_output,"m11_0:%h",cpu54_tb.test.m11_0);
                //$fdisplay(file_output,"m[11]:%h",cpu54_tb.test.m[11]);
                //$fdisplay(file_output,"rd:%h",cpu54_tb.test.rd);
                //$fdisplay(file_output,"base:%h",cpu31_tb.test.instr[25:21]); 
                //$fdisplay(file_output,"rtc:%h",cpu31_tb.test.instr[20:16]); 
                //$fdisplay(file_output,"offset:%h",cpu31_tb.test.instr[15:0]);
                //$fdisplay(file_output,"ext16:%h",cpu31_tb.test.EXT16.out);
                //$fdisplay(file_output,"rt:%h",cpu54_tb.test.RF.qb); 
                //$fdisplay(file_output,"datain:%h",cpu31_tb.test.DMEM.datain); 
                //$fdisplay(file_output,"dataout:%h",cpu54_tb.test.DMEM.dataout); 
                //$fdisplay(file_output,"addr0:%h",cpu54_tb.test.DMEM.addr0);
                //$fdisplay(file_output,"addr_:%h",cpu54_tb.test.DMEM.addr_);
                //$fdisplay(file_output,"temp:%h",cpu54_tb.test.DMEM.temp);
                //$fdisplay(file_output,"dmem_ctrl:%b",cpu54_tb.test.DMEM.dmem_ctrl);
               // $fdisplay(file_output,"REG28:%h",cpu31_tb.test.rf28_l);
                //$fdisplay(file_output,"m[1]0:%h",cpu31_tb.test.M1.a);
                //$fdisplay(file_output,"m[1]1:%h",cpu31_tb.test.M1.b);
                //$fdisplay(file_output,"m[1]:%h",cpu31_tb.test.M1.choose);
                //$fdisplay(file_output,"m[1]z:%h",cpu31_tb.test.M1.z);
                //$fdisplay(file_output,"m[6]0:%h",cpu31_tb.test.M6.a);
                //$fdisplay(file_output,"m[6]1:%h",cpu31_tb.test.M6.b);
                //$fdisplay(file_output,"m[6]:%h",cpu31_tb.test.M6.choose);
                //$fdisplay(file_output,"m[6]z:%h",cpu31_tb.test.M6.z);
                //$fdisplay(file_output,"pc:%h",cpu31_tb.test.PC.in); 
                //$fdisplay(file_output,"rsc:%h",cpu54_tb.test.RF.rna);
                //$fdisplay(file_output,"rtc:%h",cpu54_tb.test.RF.rnb);
                //$fdisplay(file_output,"rdc:%h",cpu54_tb.test.RF.wn);
                //$fdisplay(file_output,"rf_in:%h",cpu54_tb.test.RF.d);
                //$fdisplay(file_output,"rf_w:%h",cpu54_tb.test.RF.we);
                //$fdisplay(file_output,"rf_clk:%h",cpu31_tb.test.RF.clk);
               // for(i=0;i<240;i=i+1)
                    //$fdisplay(file_output,"IMEM:%h",cpu31_tb.test.IMEM.tab[i]);
                $fdisplay(file_output,"regfile0:%h",cpu54_tb.test.RF.register[0]);
                $fdisplay(file_output,"regfile1:%h",cpu54_tb.test.RF.register[1]);
                $fdisplay(file_output,"regfile2:%h",cpu54_tb.test.RF.register[2]);
                $fdisplay(file_output,"regfile3:%h",cpu54_tb.test.RF.register[3]);
                $fdisplay(file_output,"regfile4:%h",cpu54_tb.test.RF.register[4]);
                $fdisplay(file_output,"regfile5:%h",cpu54_tb.test.RF.register[5]);
                $fdisplay(file_output,"regfile6:%h",cpu54_tb.test.RF.register[6]);
                $fdisplay(file_output,"regfile7:%h",cpu54_tb.test.RF.register[7]);
                $fdisplay(file_output,"regfile8:%h",cpu54_tb.test.RF.register[8]);
                $fdisplay(file_output,"regfile9:%h",cpu54_tb.test.RF.register[9]);
                $fdisplay(file_output,"regfile10:%h",cpu54_tb.test.RF.register[10]);
                $fdisplay(file_output,"regfile11:%h",cpu54_tb.test.RF.register[11]);
                $fdisplay(file_output,"regfile12:%h",cpu54_tb.test.RF.register[12]);
                $fdisplay(file_output,"regfile13:%h",cpu54_tb.test.RF.register[13]);
                $fdisplay(file_output,"regfile14:%h",cpu54_tb.test.RF.register[14]);
                $fdisplay(file_output,"regfile15:%h",cpu54_tb.test.RF.register[15]);
                $fdisplay(file_output,"regfile16:%h",cpu54_tb.test.RF.register[16]);
                $fdisplay(file_output,"regfile17:%h",cpu54_tb.test.RF.register[17]);
                $fdisplay(file_output,"regfile18:%h",cpu54_tb.test.RF.register[18]);
                $fdisplay(file_output,"regfile19:%h",cpu54_tb.test.RF.register[19]);
                $fdisplay(file_output,"regfile20:%h",cpu54_tb.test.RF.register[20]);
                $fdisplay(file_output,"regfile21:%h",cpu54_tb.test.RF.register[21]);
                $fdisplay(file_output,"regfile22:%h",cpu54_tb.test.RF.register[22]);
                $fdisplay(file_output,"regfile23:%h",cpu54_tb.test.RF.register[23]);
                $fdisplay(file_output,"regfile24:%h",cpu54_tb.test.RF.register[24]);
                $fdisplay(file_output,"regfile25:%h",cpu54_tb.test.RF.register[25]);
                $fdisplay(file_output,"regfile26:%h",cpu54_tb.test.RF.register[26]);
                $fdisplay(file_output,"regfile27:%h",cpu54_tb.test.RF.register[27]);
                $fdisplay(file_output,"regfile28:%h",cpu54_tb.test.RF.register[28]);
                $fdisplay(file_output,"regfile29:%h",cpu54_tb.test.RF.register[29]);
                $fdisplay(file_output,"regfile30:%h",cpu54_tb.test.RF.register[30]);
                $fdisplay(file_output,"regfile31:%h",cpu54_tb.test.RF.register[31]);
             //$fdisplay(file_output,"dmem[0]:%h",cpu54_tb.test.DMEM.tab[0]);
             //$fdisplay(file_output,"dmem[4]:%h",cpu54_tb.test.DMEM.tab[1]);
             //$fdisplay(file_output,"dmem[8]:%h",cpu54_tb.test.DMEM.tab[2]);
             //$fdisplay(file_output,"dmem[12]:%h",cpu54_tb.test.DMEM.tab[3]);
             //$fdisplay(file_output,"dmem[16]:%h",cpu54_tb.test.DMEM.tab[4]);
             //$fdisplay(file_output,"dmem[20]:%h",cpu54_tb.test.DMEM.tab[5]);
             //$fdisplay(file_output,"dmem[24]:%h",cpu54_tb.test.DMEM.tab[6]);
             //$fdisplay(file_output,"dmem[28]:%h",cpu54_tb.test.DMEM.tab[7]);
             //$fdisplay(file_output,"dmem[32]:%h",cpu54_tb.test.DMEM.tab[8]);
             //$fdisplay(file_output,"dmem[36]:%h",cpu54_tb.test.DMEM.tab[9]);
             //$fdisplay(file_output,"dmem[40]:%h",cpu54_tb.test.DMEM.tab[10]);
             //$fdisplay(file_output,"dmem[44]:%h",cpu54_tb.test.DMEM.tab[11]);
             //$fdisplay(file_output,"dmem[48]:%h",cpu54_tb.test.DMEM.tab[12]);
             //$fdisplay(file_output,"dmem[52]:%h",cpu54_tb.test.DMEM.tab[13]);
             //$fdisplay(file_output,"dmem[56]:%h",cpu54_tb.test.DMEM.tab[14]);
             //$fdisplay(file_output,"dmem[60]:%h",cpu54_tb.test.DMEM.tab[15]);
             //$fdisplay(file_output,"dmem[64]:%h",cpu54_tb.test.DMEM.tab[16]);
             //$fdisplay(file_output,"dmem[68]:%h",cpu54_tb.test.DMEM.tab[17]);
             //$fdisplay(file_output,"dmem[72]:%h",cpu54_tb.test.DMEM.tab[18]);
             //$fdisplay(file_output,"dmem[76]:%h",cpu54_tb.test.DMEM.tab[19]);
             //$fdisplay(file_output,"dmem[80]:%h",cpu54_tb.test.DMEM.tab[20]);
             //$fdisplay(file_output,"dmem[84]:%h",cpu54_tb.test.DMEM.tab[21]);
             //$fdisplay(file_output,"dmem[88]:%h",cpu54_tb.test.DMEM.tab[22]);
             //$fdisplay(file_output,"dmem[92]:%h",cpu54_tb.test.DMEM.tab[23]);
             //$fdisplay(file_output,"dmem[96]:%h",cpu54_tb.test.DMEM.tab[24]);
             //$fdisplay(file_output,"dmem[100]:%h",cpu54_tb.test.DMEM.tab[25]);
             //$fdisplay(file_output,"dmem[104]:%h",cpu54_tb.test.DMEM.tab[26]);
             //$fdisplay(file_output,"dmem[108]:%h",cpu54_tb.test.DMEM.tab[27]);
             //$fdisplay(file_output,"dmem[112]:%h",cpu54_tb.test.DMEM.tab[28]);
             //$fdisplay(file_output,"dmem[116]:%h",cpu54_tb.test.DMEM.tab[29]);
             //$fdisplay(file_output,"dmem[120]:%h",cpu54_tb.test.DMEM.tab[30]);
            end
        end
    end
endmodule
