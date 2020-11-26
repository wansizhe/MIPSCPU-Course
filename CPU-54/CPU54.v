`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2017/04/12 18:57:33
// Design Name: 
// Module Name: CPU31
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

module alu(
    input [31:0] a, //32 位输入，操作数1
    input [31:0] b, //32 位输入，操作数2
    input [3:0] aluc, //4 位输入，控制 alu 的操作
    output [31:0] r, //32 位输出，由a、b 经过aluc 指定的操作生成
    output zero, //0 标志位
    output carry, // 进位标志位
    output negative, // 负数标志位
    output overflow // 溢出标志位
);
    wire [13:0]z;
    wire [5:0]c;
    wire [1:0]v;
    wire [13:0]n;
    wire [31:0] tr[13:0];
    reg tn,tc,tz,tv;
    reg [31:0] ttr;
    Addu inst0(.a(a),.b(b),.r(tr[0]),.z(z[0]),.c(c[0]),.n(n[0]));
    Add inst1(.a(a),.b(b),.r(tr[1]),.z(z[1]),.v(v[0]),.n(n[1]));
    Subu inst2(.a(a),.b(b),.r(tr[2]),.z(z[2]),.c(c[1]),.n(n[2]));
    Sub inst3(.a(a),.b(b),.r(tr[3]),.z(z[3]),.v(v[1]),.n(n[3]));
    And inst4(.a(a),.b(b),.r(tr[4]),.z(z[4]),.n(n[4]));
    Or inst5(.a(a),.b(b),.r(tr[5]),.z(z[5]),.n(n[5]));
    Xor inst6(.a(a),.b(b),.r(tr[6]),.z(z[6]),.n(n[6]));
    Nor inst7(.a(a),.b(b),.r(tr[7]),.z(z[7]),.n(n[7]));
    Lui inst8(.a(a),.b(b),.r(tr[8]),.z(z[8]),.n(n[8]));
    Slt inst9(.a(a),.b(b),.r(tr[9]),.z(z[9]),.n(n[9]));
    Sltu inst10(.a(a),.b(b),.r(tr[10]),.z(z[10]),.n(n[10]),.c(c[2]));
    Sra inst11(.a(a),.b(b),.r(tr[11]),.z(z[11]),.n(n[11]),.c(c[3]));
    Sl inst12(.a(a),.b(b),.r(tr[12]),.z(z[12]),.n(n[12]),.c(c[4]));
    Srl inst13(.a(a),.b(b),.r(tr[13]),.z(z[13]),.n(n[13]),.c(c[5]));
    
    always @(*)
    begin
        case (aluc)
        4'b0000:
        begin
            ttr=tr[0];
            tn=n[0];
            tz=z[0];
            tc=c[0];
            //tv=v[0];
        end
        4'b0010:
        begin
            ttr=tr[1];
            tn=n[1];
            tz=z[1];
            //tc=c[0];
            tv=v[0];
        end
        4'b0001:
        begin
            ttr=tr[2];
            tn=n[2];
            tz=z[2];
            tc=c[1];
            //tv=v[0];
        end
        4'b0011:
        begin
            ttr=tr[3];
            tn=n[3];
            tz=z[3];
            //tc=c[3];
            tv=v[1];
        end           
        4'b0100:
        begin
            ttr=tr[4];
            tn=n[4];
            tz=z[4];
            //tc=c[2];
            //tv=v[0];
        end
        4'b0101:
        begin
            ttr=tr[5];
            tn=n[5];
            tz=z[5];
            //tc=c[0];
            //tv=v[0];
        end
        4'b0110:
        begin
            ttr=tr[6];
            tn=n[6];
            tz=z[6];
            //tc=c[0];
            //tv=v[0];
        end             
        4'b0111:
        begin
            ttr=tr[7];
            tn=n[7];
            tz=z[7];
            //tc=c[0];
            //tv=v[0];
        end
        4'b1000:
        begin
            ttr=tr[8];
            tn=n[8];
            tz=z[8];
            //tc=c[2];
            //tv=v[0];
        end
        4'b1001:
        begin
            ttr=tr[8];
            tn=n[8];
            tz=z[8];
            //tc=c[2];
            //tv=v[0];
        end
        4'b1011:
        begin
            ttr=tr[9];
            tn=n[9];
            tz=z[9];
            //tc=c[3];
            //tv=v[0];
        end                                
        4'b1010:
        begin
            ttr=tr[10];
            tn=n[10];
            tz=z[10];
            tc=c[2];
            //tv=v[0];
        end
        4'b1100:
        begin
            ttr=tr[11];
            tn=n[11];
            tz=z[11];
            tc=c[3];
            //tv=v[0];
        end
        4'b1111:
        begin
            ttr=tr[12];
            tn=n[12];
            tz=z[12];
            tc=c[4];
            //tv=v[0];
        end                        
        4'b1110:
        begin
            ttr=tr[12];
            tn=n[12];
            tz=z[12];
            tc=c[4];
            //tv=v[0];
        end
        4'b1101:
        begin
            ttr=tr[13];
            tn=n[13];
            tz=z[13];
            tc=c[5];
            //tv=v[0];
        end
        default:
        begin
        end               
        endcase
    end
    assign r=ttr;
    assign zero=tz;
    assign carry=tc;
    assign negative=tn;
    assign overflow=tv;
endmodule

module Addu(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=a+b;
        
        tz=(tr==32'b0)?1:0;
        
        if(tr<a||tr<b) tc=1;
        else tc=0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
    assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Add(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    //output c,
    output n,
    output v
    );
    reg [31:0]tr;
    reg tz;
    //reg tc;
    reg tn;
    reg tv;
    always @(*)
    begin
        tr=a+b;
        
        tz=(tr==32'b0)?1:0;
        
        tn=tr[31];
        
        if(a[31]==b[31]&&tr[31]!=a[31]) tv=1;
        else tv=0;
        
        //if(tv==1) tr=32'd0;
    end
    assign r=tr;
    assign z=tz;
    //assign c=tc;
    assign n=tn;
    assign v=tv;
endmodule 

module Subu(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=a-b;
        
       tz=(tr==32'b0)?1:0;
        
        if(a<b) tc=1;
        else tc=0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
    assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Sub(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    //output c,
    output n,
    output v
    );
    reg [31:0]tr;
    reg tz;
    //reg tc;
    reg tn;
    reg tv;
    always @(*)
    begin
        tr=a-b;
        
        tz=(tr==32'b0)?1:0;
        
        tn=tr[31];
        
        if(a[31]!=b[31]&&tr[31]!=a[31]) tv=1;
        else tv=0;
    end
    assign r=tr;
    assign z=tz;
    //assign c=tc;
    assign n=tn;
    assign v=tv;
endmodule 

module And(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    //output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    //reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=a&b;
        
        tz=(tr==32'b0)?1:0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
   // assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Or(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    //output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    //reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=a|b;
        
        tz=(tr==32'b0)?1:0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
   // assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Xor(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    //output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    //reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=a^b;
        
        tz=(tr==32'b0)?1:0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
   // assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Nor(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    //output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    //reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=~(a|b);
        
        tz=(tr==32'b0)?1:0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
   // assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Lui(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    //output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    //reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr={b[15:0],16'b0};
        
        tz=(tr==32'b0)?1:0;
        
        //tc=0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
    //assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Slt(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    //output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        if(a[31]==0&&b[31]==1) tr=0;
        else if(a[31]==1&&b[31]==0) tr=1;
        else if(a[31]==1&&b[31]==1) tr=(a[30:0]<b[30:0])?1:0;
        else tr=(a[30:0]<b[30:0])?1:0;
        
        tz=(a==b)?1:0;
        
        //tc=0;
        
        tn=tr; 
    end
    assign r=tr;
    assign z=tz;
    //assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Sltu(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=(a<b)?1:0;
        
        tz=(a==b)?1:0;
        
        tc=(a<b)?1:0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
    assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Sra(
    input [31:0]a,
    input signed [31:0]b,
    output [31:0]r,
    output z,
    output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=b>>>a;
        
        tz=(tr==32'b0)?1:0;
        
        if(a==0) tc=0;
        else if(a<32'd33) tc=b[a-32'd1];
        else tc=b[31];
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
    assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Sl(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=b<<a;
        
        tz=(tr==32'b0)?1:0;
        
        if(a==0) tc=0;
        else if(a<32'd33) tc=b[32'd32-a];
        else tc=0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
    assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module Srl(
    input [31:0]a,
    input [31:0]b,
    output [31:0]r,
    output z,
    output c,
    output n
    //output v
    );
    reg [31:0]tr;
    reg tz;
    reg tc;
    reg tn;
    //reg tv;
    always @(*)
    begin
        tr=b>>a;
        
        tz=(tr==32'b0)?1:0;
        
        if(a==0) tc=0;
        else if(a<32'd33) tc=b[a-32'd1];
        else tc=0;
        
        tn=tr[31]; 
    end
    assign r=tr;
    assign z=tz;
    assign c=tc;
    assign n=tn;
    //assign v=tv;
endmodule 

module mux32(
    input [31:0] a, //0
    input [31:0] b, //1
    input choose,
    output [31:0] z
    );
    reg [31:0]temp;
    always @(*)
    begin
        if(choose==0)
            temp=a;
        else
            temp=b;
    end
    assign z=temp;
endmodule

module mux5(
    input [4:0] a, //0
    input [4:0] b, //1
    input choose,
    output [4:0] z
    );
    reg [4:0]temp;
    always @(*)
    begin
        if(choose==0)
            temp=a;
        else
            temp=b;
    end
    assign z=temp;
endmodule

module regfile(
    input [4:0] rna,    //Rsc
    input [4:0] rnb,    //Rtc
    input [4:0] wn,     //Rdc
    input [31:0] d,     //Rd
    input clk,
    input we,
    input clr,
    output [31:0] qa,   //Rs
    output [31:0] qb    //Rt
    //output [15:0] reg28
    );
    reg [31:0] register [0:31];
    integer i;
    assign qa=(rna==0)?0:register[rna];
    assign qb=(rnb==0)?0:register[rnb];
    always @(negedge clk or posedge clr)
    begin
        if(clr)
        begin
            for(i=0;i<32;i=i+1)
                register[i]<=0;
        end
        else if((wn)&&we)
            register[wn]<=d;
    end
    assign reg28=register[28][15:0];
endmodule

module multu(
    input [31:0] a,
    input [31:0] b,
    output [63:0] z
    );
    reg [63:0] temp;
    reg [63:0] stored0;
    reg [63:0] stored1;
    reg [63:0] stored2;
    reg [63:0] stored3;
    reg [63:0] stored4;
    reg [63:0] stored5;
    reg [63:0] stored6;
    reg [63:0] stored7;
    reg [63:0] stored8;
    reg [63:0] stored9;
    reg [63:0] stored10;
    reg [63:0] stored11;
    reg [63:0] stored12;
    reg [63:0] stored13;
    reg [63:0] stored14;
    reg [63:0] stored15;
    reg [63:0] stored16;
    reg [63:0] stored17;
    reg [63:0] stored18;
    reg [63:0] stored19;
    reg [63:0] stored20;
    reg [63:0] stored21;
    reg [63:0] stored22;
    reg [63:0] stored23;
    reg [63:0] stored24;
    reg [63:0] stored25;
    reg [63:0] stored26;
    reg [63:0] stored27;
    reg [63:0] stored28;
    reg [63:0] stored29;
    reg [63:0] stored30;
    reg [63:0] stored31;
    reg [63:0] add0_1;
    reg [63:0] add2_3;
    reg [63:0] add4_5;
    reg [63:0] add6_7;
    reg [63:0] add8_9;
    reg [63:0] add10_11;
    reg [63:0] add12_13;
    reg [63:0] add14_15;
    reg [63:0] add16_17;
    reg [63:0] add18_19;
    reg [63:0] add20_21;
    reg [63:0] add22_23;
    reg [63:0] add24_25;
    reg [63:0] add26_27;
    reg [63:0] add28_29;
    reg [63:0] add30_31;
    reg [63:0] add0t1_2t3;
    reg [63:0] add4t5_6t7;
    reg [63:0] add8t9_10t11;
    reg [63:0] add12t13_14t15;
    reg [63:0] add16t17_18t19;
    reg [63:0] add20t21_22t23;
    reg [63:0] add24t25_26t27;
    reg [63:0] add28t29_30t31;
    reg [63:0] add0t7;
    reg [63:0] add8t15;
    reg [63:0] add16t23;
    reg [63:0] add24t31;
    reg [63:0] add0t15;
    reg [63:0] add16t31;
    
    always @(*)
        begin
            stored0<=b[0]?{32'b0,a}:64'b0;
            stored1<=b[1]?{31'b0,a,1'b0}:64'b0;
            stored2<=b[2]?{30'b0,a,2'b0}:64'b0;
            stored3<=b[3]?{29'b0,a,3'b0}:64'b0;
            stored4<=b[4]?{28'b0,a,4'b0}:64'b0;
            stored5<=b[5]?{27'b0,a,5'b0}:64'b0;
            stored6<=b[6]?{26'b0,a,6'b0}:64'b0;
            stored7<=b[7]?{25'b0,a,7'b0}:64'b0;
            stored8<=b[8]?{24'b0,a,8'b0}:64'b0;
            stored9<=b[9]?{23'b0,a,9'b0}:64'b0;
            stored10<=b[10]?{22'b0,a,10'b0}:64'b0;
            stored11<=b[11]?{21'b0,a,11'b0}:64'b0;
            stored12<=b[12]?{20'b0,a,12'b0}:64'b0;
            stored13<=b[13]?{19'b0,a,13'b0}:64'b0;
            stored14<=b[14]?{18'b0,a,14'b0}:64'b0;
            stored15<=b[15]?{17'b0,a,15'b0}:64'b0;
            stored16<=b[16]?{16'b0,a,16'b0}:64'b0;
            stored17<=b[17]?{15'b0,a,17'b0}:64'b0;
            stored18<=b[18]?{14'b0,a,18'b0}:64'b0;
            stored19<=b[19]?{13'b0,a,19'b0}:64'b0;
            stored20<=b[20]?{12'b0,a,20'b0}:64'b0;
            stored21<=b[21]?{11'b0,a,21'b0}:64'b0;
            stored22<=b[22]?{10'b0,a,22'b0}:64'b0;
            stored23<=b[23]?{9'b0,a,23'b0}:64'b0;
            stored24<=b[24]?{8'b0,a,24'b0}:64'b0;
            stored25<=b[25]?{7'b0,a,25'b0}:64'b0;
            stored26<=b[26]?{6'b0,a,26'b0}:64'b0;
            stored27<=b[27]?{5'b0,a,27'b0}:64'b0;
            stored28<=b[28]?{4'b0,a,28'b0}:64'b0;
            stored29<=b[29]?{3'b0,a,29'b0}:64'b0;
            stored30<=b[30]?{2'b0,a,30'b0}:64'b0;
            stored31<=b[31]?{1'b0,a,31'b0}:64'b0;
            add0_1<=stored0+stored1;
            add2_3<=stored2+stored3;
            add4_5<=stored4+stored5;
            add6_7<=stored6+stored7;
            add8_9<=stored8+stored9;
            add10_11<=stored10+stored11;
            add12_13<=stored12+stored13;
            add14_15<=stored14+stored15;
            add16_17<=stored16+stored17;
            add18_19<=stored18+stored19;
            add20_21<=stored20+stored21;
            add22_23<=stored22+stored23;
            add24_25<=stored24+stored25;
            add26_27<=stored26+stored27;
            add28_29<=stored28+stored29;
            add30_31<=stored30+stored31;
            add0t1_2t3<=add0_1+add2_3;
            add4t5_6t7<=add4_5+add6_7;
            add8t9_10t11<=add8_9+add10_11;
            add12t13_14t15<=add12_13+add14_15;
            add16t17_18t19<=add16_17+add18_19;
            add20t21_22t23<=add20_21+add22_23;
            add24t25_26t27<=add24_25+add26_27;
            add28t29_30t31<=add28_29+add30_31;
            add0t7<=add0t1_2t3+add4t5_6t7;
            add8t15<=add8t9_10t11+add12t13_14t15;
            add16t23<=add16t17_18t19+add20t21_22t23;
            add24t31<=add24t25_26t27+add28t29_30t31;
            add0t15<=add0t7+add8t15;
            add16t31<=add16t23+add24t31;
            temp<=add0t15+add16t31;
        end
    assign z=temp;
endmodule

module mul(
    input [31:0] a,
    input [31:0] b,
    output [63:0] z
    );
    reg [31:0] ab00;
    reg [31:0] ab01;
    reg [31:0] ab02;
    reg [31:0] ab03;
    reg [31:0] ab04;
    reg [31:0] ab05;
    reg [31:0] ab06;
    reg [31:0] ab07;
    reg [31:0] ab08;
    reg [31:0] ab09;
    reg [31:0] ab10;
    reg [31:0] ab11;
    reg [31:0] ab12;
    reg [31:0] ab13;
    reg [31:0] ab14;
    reg [31:0] ab15;
    reg [31:0] ab16;
    reg [31:0] ab17;
    reg [31:0] ab18;
    reg [31:0] ab19;
    reg [31:0] ab20;
    reg [31:0] ab21;
    reg [31:0] ab22;
    reg [31:0] ab23;
    reg [31:0] ab24;
    reg [31:0] ab25;
    reg [31:0] ab26;
    reg [31:0] ab27;
    reg [31:0] ab28;
    reg [31:0] ab29;
    reg [31:0] ab30;
    reg [31:0] ab31;
    reg [63:0] temp;
    
    always @(*)
    begin
        ab00<=b[0]?a:32'b0;
        ab01<=b[1]?a:32'b0;
        ab02<=b[2]?a:32'b0;
        ab03<=b[3]?a:32'b0;
        ab04<=b[4]?a:32'b0;
        ab05<=b[5]?a:32'b0;
        ab06<=b[6]?a:32'b0;
        ab07<=b[7]?a:32'b0;
        ab08<=b[8]?a:32'b0;
        ab09<=b[9]?a:32'b0;
        ab10<=b[10]?a:32'b0;
        ab11<=b[11]?a:32'b0;
        ab12<=b[12]?a:32'b0;
        ab13<=b[13]?a:32'b0;
        ab14<=b[14]?a:32'b0;
        ab15<=b[15]?a:32'b0;
        ab16<=b[16]?a:32'b0;
        ab17<=b[17]?a:32'b0;
        ab18<=b[18]?a:32'b0;
        ab19<=b[19]?a:32'b0;
        ab20<=b[20]?a:32'b0;
        ab21<=b[21]?a:32'b0;
        ab22<=b[22]?a:32'b0;
        ab23<=b[23]?a:32'b0;
        ab24<=b[24]?a:32'b0;
        ab25<=b[25]?a:32'b0;
        ab26<=b[26]?a:32'b0;
        ab27<=b[27]?a:32'b0;
        ab28<=b[28]?a:32'b0;
        ab29<=b[29]?a:32'b0;
        ab30<=b[30]?a:32'b0;
        ab31<=b[31]?a:32'b0;
    
       temp<=(({32'b1,~ab00[31],ab00[30:0]}        +
               {31'b0,~ab01[31],ab01[30:0], 1'b0}) +
              ({30'b0,~ab02[31],ab02[30:0], 2'b0}  +
               {29'b0,~ab03[31],ab03[30:0], 3'b0}))+
             (({28'b0,~ab04[31],ab04[30:0], 4'b0}  +
               {27'b0,~ab05[31],ab05[30:0], 5'b0}) +
              ({26'b0,~ab06[31],ab06[30:0], 6'b0}  +
               {25'b0,~ab07[31],ab07[30:0], 7'b0}))+
             (({24'b0,~ab08[31],ab08[30:0], 8'b0}  +
               {23'b0,~ab09[31],ab09[30:0], 9'b0}) +
              ({22'b0,~ab10[31],ab10[30:0],10'b0}  +
               {21'b0,~ab11[31],ab11[30:0],11'b0}))+
             (({20'b0,~ab12[31],ab12[30:0],12'b0}  +
               {19'b0,~ab13[31],ab13[30:0],13'b0}) +
              ({18'b0,~ab14[31],ab14[30:0],14'b0}  +
               {17'b0,~ab15[31],ab15[30:0],15'b0}))+
             (({16'b0,~ab16[31],ab16[30:0],16'b0}  +
               {15'b0,~ab17[31],ab17[30:0],17'b0}) +
              ({14'b0,~ab18[31],ab18[30:0],18'b0}  +
               {13'b0,~ab19[31],ab19[30:0],19'b0}))+
             (({12'b0,~ab20[31],ab20[30:0],20'b0}  +
               {11'b0,~ab21[31],ab21[30:0],21'b0}) +
              ({10'b0,~ab22[31],ab22[30:0],22'b0}  +
               { 9'b0,~ab23[31],ab23[30:0],23'b0}))+
             (({ 8'b0,~ab24[31],ab24[30:0],24'b0}  +
               { 7'b0,~ab25[31],ab25[30:0],25'b0}) +
              ({ 6'b0,~ab26[31],ab26[30:0],26'b0}  +
               { 5'b0,~ab27[31],ab27[30:0],27'b0}))+
             (({ 4'b0,~ab28[31],ab28[30:0],28'b0}  +
               { 3'b0,~ab29[31],ab29[30:0],29'b0}) +
              ({ 2'b0,~ab30[31],ab30[30:0],30'b0}  +
               { 1'b1,ab31[31],~ab31[30:0],31'b0}));
    end
    assign z=temp;
endmodule

module controller(
    input clk,
    input [5:0] op,
    input [5:0] func,
    input [31:0] format,
    input z, //ALU的Z端
    input rs_sign,
    output [3:0] aluc,
    output rf_w,
    output rf_clk,
    output dm_cs,
    output dm_r,
    output dm_w,
    output [22:0] m,
    output [4:0] rsc,
    output [4:0] rtc,
    output hi_ena,
    output lo_ena,
    output hi_we,
    output lo_we,
    output cp0_eret,
    output cp0_exc,
    output mfc0,
    output mtc0,
    output pc0,
    output extsign,
    output [4:0] cause,
    output [7:0] dmem_ctrl//{sh,lh,lhu,sb,lb,lbu,sw,lw}
    );
    wire r_type=~|op;
    wire i_add=r_type&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire i_addu=r_type&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&func[0];
    wire i_sub=r_type&func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0];
    wire i_subu=r_type&func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0];
    wire i_and=r_type&func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0];
    wire i_or=r_type&func[5]&~func[4]&~func[3]&func[2]&~func[1]&func[0];
    wire i_xor=r_type&func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0];
    wire i_nor=r_type&func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0];
    wire i_slt=r_type&func[5]&~func[4]&func[3]&~func[2]&func[1]&~func[0];
    wire i_sltu=r_type&func[5]&~func[4]&func[3]&~func[2]&func[1]&func[0];
    wire i_sll=r_type&~func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire i_srl=r_type&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0];
    wire i_sra=r_type&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0];
    wire i_sllv=r_type&~func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0];
    wire i_srlv=r_type&~func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0];
    wire i_srav=r_type&~func[5]&~func[4]&~func[3]&func[2]&func[1]&func[0];
    wire i_jr=r_type&~func[5]&~func[4]&func[3]&~func[2]&~func[1]&~func[0];
    wire i_addi=~op[5]&~op[4]&op[3]&~op[2]&~op[1]&~op[0];
    wire i_addiu=~op[5]&~op[4]&op[3]&~op[2]&~op[1]&op[0];
    wire i_andi=~op[5]&~op[4]&op[3]&op[2]&~op[1]&~op[0];
    wire i_ori=~op[5]&~op[4]&op[3]&op[2]&~op[1]&op[0];
    wire i_xori=~op[5]&~op[4]&op[3]&op[2]&op[1]&~op[0];
    wire i_lw=op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
    wire i_sw=op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];
    wire i_beq=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];
    wire i_bne=~op[5]&~op[4]&~op[3]&op[2]&~op[1]&op[0];
    wire i_slti=~op[5]&~op[4]&op[3]&~op[2]&op[1]&~op[0];
    wire i_sltiu=~op[5]&~op[4]&op[3]&~op[2]&op[1]&op[0];
    wire i_lui=~op[5]&~op[4]&op[3]&op[2]&op[1]&op[0];
    wire i_j=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&~op[0];
    wire i_jal=~op[5]&~op[4]&~op[3]&~op[2]&op[1]&op[0];
    
    wire i_clz=~op[5]&op[4]&op[3]&op[2]&~op[1]&~op[0]&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire i_divu=r_type&~func[5]&func[4]&func[3]&~func[2]&func[1]&func[0];
    wire i_eret=~op[5]&op[4]&~op[3]&~op[2]&~op[1]&~op[0]&~func[5]&func[4]&func[3]&~func[2]&~func[1]&~func[0];
    wire i_jalr=r_type&~func[5]&~func[4]&func[3]&~func[2]&~func[1]&func[0];
    wire i_lb=op[5]&~op[4]&~op[3]&~op[2]&~op[1]&~op[0];
    wire i_lbu=op[5]&~op[4]&~op[3]&op[2]&~op[1]&~op[0];
    wire i_lhu=op[5]&~op[4]&~op[3]&op[2]&~op[1]&op[0];
    wire i_sb=op[5]&~op[4]&op[3]&~op[2]&~op[1]&~op[0];
    wire i_sh=op[5]&~op[4]&op[3]&~op[2]&~op[1]&op[0];
    wire i_lh=op[5]&~op[4]&~op[3]&~op[2]&~op[1]&op[0];
    wire i_mfc0=~op[5]&op[4]&~op[3]&~op[2]&~op[1]&~op[0]&~format[25]&~format[24]&~format[23]&~format[22]&~format[21];
    wire i_mfhi=r_type&~func[5]&func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire i_mflo=r_type&~func[5]&func[4]&~func[3]&~func[2]&func[1]&~func[0];
    wire i_mtc0=~op[5]&op[4]&~op[3]&~op[2]&~op[1]&~op[0]&~format[25]&~format[24]&format[23]&~format[22]&~format[21];
    wire i_mthi=r_type&~func[5]&func[4]&~func[3]&~func[2]&~func[1]&func[0];
    wire i_mtlo=r_type&~func[5]&func[4]&~func[3]&~func[2]&func[1]&func[0];
    wire i_mul=~op[5]&op[4]&op[3]&op[2]&~op[1]&~op[0]&~func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0];
    wire i_multu=r_type&~func[5]&func[4]&func[3]&~func[2]&~func[1]&func[0];
    wire i_syscall=r_type&~func[5]&~func[4]&func[3]&func[2]&~func[1]&~func[0];
    wire i_teq=r_type&func[5]&func[4]&~func[3]&func[2]&~func[1]&~func[0];
    wire i_bgez=~op[5]&~op[4]&~op[3]&~op[2]&~op[1]&op[0];
    wire i_break=r_type&~func[5]&~func[4]&func[3]&func[2]&~func[1]&func[0];
    wire i_div=r_type&~func[5]&func[4]&func[3]&~func[2]&func[1]&~func[0];
    
    //assign pc_clk=clk;
    //assign im_r=1;
    assign aluc[3]=i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_slti|i_sltiu|i_lui;
    assign aluc[2]=i_and|i_or|i_xor|i_nor|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_andi|i_ori|i_xori;
    assign aluc[1]=i_lb|i_lbu|i_lhu|i_sb|i_sh|i_lh|i_add|i_sub|i_xor|i_nor|i_slt|i_sltu|i_sll|i_sllv|i_addi|i_xori|i_lw|i_sw|i_beq|i_bne|i_slti|i_sltiu;
    assign aluc[0]=i_sub|i_subu|i_or|i_slt|i_nor|i_srl|i_srlv|i_ori|i_beq|i_bne|i_slti;
    assign rf_w=i_clz|i_jalr|i_lb|i_lbu|i_lhu|i_lh|i_mfc0|i_mfhi|i_mflo|i_mul|i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_slti|i_sltiu|i_lui|i_jal|i_clz;
    assign rf_clk=clk;//(i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_slti|i_sltiu|i_lui)&clk;
    assign dm_cs=i_lb|i_lbu|i_lhu|i_sb|i_sh|i_lh|i_lw|i_sw;
    assign dm_r=i_lb|i_lbu|i_lhu|i_lh|i_lw;
    assign dm_w=i_sb|i_sh|i_sw;
    assign m[0]=0;
    assign m[1]=i_clz|i_divu|i_jalr|i_lb|i_lbu|i_lhu|i_sb|i_sh|i_lh|i_mfc0|i_mfhi|i_mflo|i_mtc0|i_mthi|i_mtlo|i_mul|i_multu|i_bgez|i_div|i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_sw|i_beq|i_bne|i_slti|i_sltiu|i_lui;
    assign m[2]=i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_slti|i_sltiu|i_lui;
    assign m[3]=i_lb|i_lbu|i_lhu|i_sb|i_sh|i_lh|i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_sw|i_beq|i_bne|i_slti|i_sltiu;
    assign m[4]=i_lb|i_lbu|i_lhu|i_sb|i_sh|i_lh|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_sw|i_slti|i_sltiu|i_lui;
    assign m[5]=i_clz|i_divu|i_lb|i_lbu|i_lhu|i_sb|i_sh|i_lh|i_mfc0|i_mfhi|i_mflo|i_mtc0|i_mthi|i_mtlo|i_mul|i_multu|i_div|(i_bgez&rs_sign)|i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_sw|i_beq&~z|i_bne&z|i_slti|i_sltiu|i_lui;
    assign m[6]=i_jr|i_jalr;
    assign m[7]=i_lb|i_lbu|i_lhu|i_lh|i_mfhi|i_mflo|i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_jr|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_slti|i_sltiu|i_lui;
    assign m[8]=i_mfc0|i_lb|i_lbu|i_lhu|i_lh|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_slti|i_sltiu|i_lui;
    assign m[9]=i_jal;
    assign m[10]=i_eret|i_break|i_syscall|i_teq;
    assign m[11]=i_clz|i_mfc0|i_mul;
    assign m[12]=i_divu|i_div;
    assign m[13]=i_mul;
    assign m[14]=0;
    assign m[15]=i_divu;
    assign m[16]=i_div;
    assign m[17]=i_mfc0|i_mul;
    assign m[18]=0;
    assign m[19]=i_divu|i_multu|i_div;
    assign m[20]=i_divu|i_multu|i_div;
    assign m[21]=i_mfhi|i_mflo;
    assign m[22]=i_mfhi;
    assign rsc[4:0]=format[25:21];
    assign rtc[4:0]=format[20:16];
    assign pc0=i_jr|i_j|i_jal;
    assign extsign=i_addi|i_addiu|i_lw|i_sw|i_slti|i_sltiu;
    assign hi_ena=i_mthi|i_mfhi|i_div|i_divu|i_multu;
    assign lo_ena=i_mtlo|i_mflo|i_div|i_divu|i_multu;
    assign hi_we=i_mthi|i_div|i_divu|i_multu;
    assign lo_we=i_mtlo|i_div|i_divu|i_multu;
    assign cp0_eret=i_eret;
    assign cp0_exc=i_syscall|i_break|i_teq;
    assign mfc0=i_mfc0;
    assign mtc0=i_mtc0;
    assign cause=i_syscall?5'b01000:i_teq?5'b01101:i_break?5'b01001:5'b0;
    assign dmem_ctrl[7]=i_sh;
    assign dmem_ctrl[6]=i_lh;
    assign dmem_ctrl[5]=i_lhu;
    assign dmem_ctrl[4]=i_sb;
    assign dmem_ctrl[3]=i_lb;
    assign dmem_ctrl[2]=i_lbu;
    assign dmem_ctrl[1]=i_sw;
    assign dmem_ctrl[0]=i_lw;
endmodule

module pc(
    input [31:0] in,
    input clk,
    input pc0,
    input rst,
    output [31:0] out
    );
    reg [31:0] temp;
    always @(posedge clk or posedge rst)
    begin
        if(rst)
            temp=32'h00400000;
        else
        begin
            //if(pc0)
                temp=in;
            //else
                //temp=in;
        end
    end
    assign out=temp;
endmodule

module npc(
    input [31:0] in,
    output [31:0] out
    );
    assign out=in+32'h00000004;
endmodule

module dmem(
    input clk,
    input [31:0] datain,
    input [31:0] addr,
    input dm_w,
    //input dm_r,
    input dm_cs,
    input rst,
    input [7:0] dmem_ctrl,//{sh,lh,lhu,sb,lb,lbu,sw,lw}
    output [31:0] dataout
    );
    reg [31:0] tab[0:300];
    wire [31:0] addr0=addr-32'h10010000;
    wire [31:0] addr_={2'b00,addr0[31:2]};
    reg [31:0] temp;
    wire [31:0] remind=addr0-{addr0[31:2],2'b00};
    integer i;
    always @(posedge clk or posedge rst)
    begin
    if(rst)
        for(i=0;i<300;i=i+1)
            tab[i]=8'b0;
    else if(dm_cs)
    begin
        if(dm_w)
        begin
            case(dmem_ctrl)
            8'b10000000://sh
                if(remind==0)   tab[{2'b00,addr0[31:2]}][15:0]=datain[15:0];
                else if(remind==1)  tab[{2'b00,addr0[31:2]}][23:8]=datain[15:0];
                else if(remind==2)  tab[{2'b00,addr0[31:2]}][31:16]=datain[15:0];
                else if(remind==3)
                begin
                    tab[{2'b00,addr0[31:2]}][31:24]=datain[7:0];
                    tab[{2'b00,addr0[31:2]}+1][7:0]=datain[15:8];
                end
            8'b00010000://sb
                if(remind==0)   tab[{2'b00,addr0[31:2]}][7:0]=datain[7:0];
                else if(remind==1)  tab[{2'b00,addr0[31:2]}][15:8]=datain[7:0];
                else if(remind==2)  tab[{2'b00,addr0[31:2]}][23:16]=datain[7:0];
                else if(remind==3)  tab[{2'b00,addr0[31:2]}][31:24]=datain[7:0];
            8'b00000010:tab[{2'b00,addr0[31:2]}]=datain;//sw
            default:;
            endcase
        end
    end
    end
    always @(*)
    begin
        case(dmem_ctrl)
        8'b00000001:temp=tab[{2'b00,addr0[31:2]}];//lw
        8'b00000100://lbu
            if(remind==0)   temp={24'b0,tab[{2'b00,addr0[31:2]}][7:0]};
            else if(remind==1)  temp={24'b0,tab[{2'b00,addr0[31:2]}][15:8]};
            else if(remind==2)  temp={24'b0,tab[{2'b00,addr0[31:2]}][23:16]};
            else if(remind==3)  temp={24'b0,tab[{2'b00,addr0[31:2]}][31:24]};
        8'b00001000://lb
            if(remind==0)   temp={{24{tab[{2'b00,addr0[31:2]}][7]}},tab[{2'b00,addr0[31:2]}][7:0]};
            else if(remind==1)  temp={{24{tab[{2'b00,addr0[31:2]}][15]}},tab[{2'b00,addr0[31:2]}][15:8]};
            else if(remind==2)  temp={{24{tab[{2'b00,addr0[31:2]}][23]}},tab[{2'b00,addr0[31:2]}][23:16]};
            else if(remind==3)  temp={{24{tab[{2'b00,addr0[31:2]}][31]}},tab[{2'b00,addr0[31:2]}][31:24]};
        8'b00100000://lhu
            if(remind==0)   temp={16'b0,tab[{2'b00,addr0[31:2]}][15:0]};
            else if(remind==1)  temp={16'b0,tab[{2'b00,addr0[31:2]}][23:8]};
            else if(remind==2)  temp={16'b0,tab[{2'b00,addr0[31:2]}][31:16]};
            else if(remind==3)  
            begin
                temp[7:0]=tab[{2'b00,addr0[31:2]}][31:24];
                temp[15:8]=tab[{2'b00,addr0[31:2]}+1][7:0];
                temp[31:16]=16'b0;
            end
        8'b01000000://lh
            if(remind==0)   temp={{16{tab[{2'b00,addr0[31:2]}][15]}},tab[{2'b00,addr0[31:2]}][15:0]};
            else if(remind==1)  temp={{16{tab[{2'b00,addr0[31:2]}][23]}},tab[{2'b00,addr0[31:2]}][23:8]};
            else if(remind==2)  temp={{16{tab[{2'b00,addr0[31:2]}][31]}},tab[{2'b00,addr0[31:2]}][31:16]};
            else if(remind==3)  
            begin
                temp[7:0]=tab[{2'b00,addr0[31:2]}][31:24];
                temp[15:8]=tab[{2'b00,addr0[31:2]}+1][7:0];
                temp[31:16]={16{tab[{2'b00,addr0[31:2]}+1][7]}};
            end
        default:;
        endcase
    end
    assign dataout=temp;//tab[{2'b00,addr0[31:2]}];
endmodule

module imem(
    input [31:0] addr,
    //input im_r,
    //input rst,
    output[31:0] instr
    );
    reg [31:0] tab[0:1023];
    reg [31:0]temp;
    integer i;
    initial
    begin
        for(i=0;i<1024;i=i+1)
            tab[i]=0;
        $readmemh("E:\\cpu_input.txt",tab);
    end
    assign instr=tab[addr];
    //assign instr[7:0]=tab[addr+3];
    //assign instr[15:8]=tab[addr+2];
    //assign instr[23:16]=tab[addr+1];
    //assign instr[31:24]=tab[addr];
endmodule

module ext16(
    input [15:0] in,
    input s,
    output [31:0] out
    );
    reg [31:0] temp;
    always @(*)
    begin
        if(s)
        begin
            temp={(in[15]==0?16'b0:16'hffff),in};
        end
        else
        begin
            temp={16'b0,in};
        end
    end
    assign out=temp;
endmodule

module hi_lo(
    input [31:0] data_in,
    input clk,
    input ena,
    input we,
    output [31:0] data_out
    );
    reg [31:0] temp;
    reg [31:0] data;
    always @(posedge clk)
    begin
        if(ena)
        begin
            if(we)  
            begin
                data<=data_in;
            end
        end
    end
    assign data_out=data;
endmodule

module cp0(
    input clk,
    input rst,
    input mfc0,
    input mtc0,
    input [31:0] pc,
    input [4:0] addr,
    input [31:0] data,
    input exception,
    input eret,
    input [4:0] cause,
    output [31:0] rdata,
    output [31:0] status,
    output [31:0] exc_addr
    );
    reg [31:0] tab[0:31];
    
    always @(negedge clk or posedge rst)
    begin
        if(rst)
        begin
            tab[12][3:0]<=4'b1;
            tab[13]<=32'b0;
            tab[14]<=32'b0;
        end
        else
        begin
            if(mtc0)
            begin
                tab[addr]<=data;
            end
            else if(exception&&tab[12][3:1]!=0)
            begin
                tab[13][6:2]<=cause;
                tab[12]<=tab[12]<<5'd5;
                tab[14]<=pc;
            end
            else if(eret)
            begin
                tab[12]<=tab[12]>>5'd5;
            end
        end
    end
    assign rdata=tab[addr];
    assign status=tab[12];
    assign exc_addr=eret?tab[14]:(32'h4+32'h00400000);
endmodule

module clz(
    input [31:0] data,
    output [31:0] count
    );
    reg [31:0] temp;
    always@(*)
    begin
        if(data[31])    temp=32'd0;
        else if(data[30])   temp=32'd1;
        else if(data[29])   temp=32'd2;
        else if(data[28])   temp=32'd3;
        else if(data[27])   temp=32'd4;
        else if(data[26])   temp=32'd5;
        else if(data[25])   temp=32'd6;
        else if(data[24])   temp=32'd7;
        else if(data[23])   temp=32'd8;
        else if(data[22])   temp=32'd9;
        else if(data[21])   temp=32'd10;
        else if(data[20])   temp=32'd11;
        else if(data[19])   temp=32'd12;
        else if(data[18])   temp=32'd13;
        else if(data[17])   temp=32'd14;
        else if(data[16])   temp=32'd15;
        else if(data[15])   temp=32'd16;
        else if(data[14])   temp=32'd17;
        else if(data[13])   temp=32'd18;
        else if(data[12])   temp=32'd19;
        else if(data[11])   temp=32'd20;
        else if(data[10])   temp=32'd21;
        else if(data[9])   temp=32'd22;
        else if(data[8])   temp=32'd23;
        else if(data[7])   temp=32'd24;
        else if(data[6])   temp=32'd25;
        else if(data[5])   temp=32'd26;
        else if(data[4])   temp=32'd27;
        else if(data[3])   temp=32'd28;
        else if(data[2])   temp=32'd29;
        else if(data[1])   temp=32'd30;
        else if(data[0])   temp=32'd31;
        else    temp=32'd32;
    end
    assign count=temp;
endmodule

/*
module io_sel(
    input [31:0] addr,
	 input cs,
	 input sig_w,
	 input sig_r,
	 output seg7_cs,
	 output switch_cs
    );

assign seg7_cs = (addr == 32'h10010000 && cs == 1 && sig_w == 1) ? 1 : 0;
assign switch_cs = (addr == 32'h10010010 && cs == 1 && sig_r == 1) ? 1 : 0;
endmodule

module seg7x16(
    input clk,
	 input reset,
	 input cs,
	 input [31:0] i_data,
	 output [7:0] o_seg,
	 output [7:0] o_sel
    );

    reg [14:0] cnt;
	 always @ (posedge clk, posedge reset)
      if (reset)
        cnt <= 0;
      else
        cnt <= cnt + 1'b1;
 
    wire seg7_clk = cnt[14]; 
	 
	 reg [2:0] seg7_addr;
	 
	 always @ (posedge seg7_clk, posedge reset)
	   if(reset)
		  seg7_addr <= 0;
		else
		  seg7_addr <= seg7_addr + 1'b1;
		  
	 reg [7:0] o_sel_r;
	 
	 always @ (*)
	   case(seg7_addr)
		  7 : o_sel_r = 8'b01111111;
		  6 : o_sel_r = 8'b10111111;
		  5 : o_sel_r = 8'b11011111;
		  4 : o_sel_r = 8'b11101111;
		  3 : o_sel_r = 8'b11110111;
		  2 : o_sel_r = 8'b11111011;
		  1 : o_sel_r = 8'b11111101;
		  0 : o_sel_r = 8'b11111110;
		endcase
	
	 reg [31:0] i_data_store;
	 always @ (posedge clk, posedge reset)
	   if(reset)
		  i_data_store <= 0;
		else if(cs)
		  i_data_store <= i_data;
		  
	 reg [7:0] seg_data_r;
	 always @ (*)
	   case(seg7_addr)
		  0 : seg_data_r = i_data_store[3:0];
		  1 : seg_data_r = i_data_store[7:4];
		  2 : seg_data_r = i_data_store[11:8];
		  3 : seg_data_r = i_data_store[15:12];
		  4 : seg_data_r = i_data_store[19:16];
		  5 : seg_data_r = i_data_store[23:20];
		  6 : seg_data_r = i_data_store[27:24];
		  7 : seg_data_r = i_data_store[31:28];
		endcase
	 
	 reg [7:0] o_seg_r;
	 always @ (posedge clk, posedge reset)
	   if(reset)
		  o_seg_r <= 8'hff;
		else
		  case(seg_data_r)
		    4'h0 : o_seg_r <= 8'hC0;
          4'h1 : o_seg_r <= 8'hF9;
          4'h2 : o_seg_r <= 8'hA4;
          4'h3 : o_seg_r <= 8'hB0;
          4'h4 : o_seg_r <= 8'h99;
          4'h5 : o_seg_r <= 8'h92;
          4'h6 : o_seg_r <= 8'h82;
          4'h7 : o_seg_r <= 8'hF8;
          4'h8 : o_seg_r <= 8'h80;
          4'h9 : o_seg_r <= 8'h90;
          4'hA : o_seg_r <= 8'h88;
          4'hB : o_seg_r <= 8'h83;
          4'hC : o_seg_r <= 8'hC6;
          4'hD : o_seg_r <= 8'hA1;
          4'hE : o_seg_r <= 8'h86;
          4'hF : o_seg_r <= 8'h8E;
		  endcase
		  
	 assign o_sel = o_sel_r;
	 assign o_seg = o_seg_r;

endmodule

module sw_mem_sel(
    input [31:0] switch_cs,
	 input [15:0] sw,
	 input [31:0] data,
	 output [31:0] data_sel
    );

    assign data_sel = (switch_cs) ? {16'b0, sw[15:0]} : data;
endmodule
*/
/*
module io_sel(
    input [31:0] addr,
	 input cs,
	 output seg7_cs
    );

assign seg7_cs = (addr == 32'h10010000 && cs == 1) ? 1 : 0;
endmodule

module seg7x16(
    input clk,
	 input reset,
	 input cs,
	 input [31:0] i_data,
	 output [7:0] o_seg,
	 output [7:0] o_sel
    );

    reg [14:0] cnt;
	 always @ (posedge clk, posedge reset)
      if (reset)
        cnt <= 0;
      else
        cnt <= cnt + 1'b1;
 
    wire seg7_clk = cnt[14]; 
	 
	 reg [2:0] seg7_addr;
	 
	 always @ (posedge seg7_clk, posedge reset)
	   if(reset)
		  seg7_addr <= 0;
		else
		  seg7_addr <= seg7_addr + 1'b1;
		  
	 reg [7:0] o_sel_r;
	 
	 always @ (*)
	   case(seg7_addr)
		  7 : o_sel_r = 8'b01111111;
		  6 : o_sel_r = 8'b10111111;
		  5 : o_sel_r = 8'b11011111;
		  4 : o_sel_r = 8'b11101111;
		  3 : o_sel_r = 8'b11110111;
		  2 : o_sel_r = 8'b11111011;
		  1 : o_sel_r = 8'b11111101;
		  0 : o_sel_r = 8'b11111110;
		endcase
	
	 reg [31:0] i_data_store;
	 always @ (posedge clk, posedge reset)
	   if(reset)
		  i_data_store <= 0;
		else if(cs)
		  i_data_store <= i_data;
		  
	 reg [7:0] seg_data_r;
	 always @ (*)
	   case(seg7_addr)
		  0 : seg_data_r = i_data_store[3:0];
		  1 : seg_data_r = i_data_store[7:4];
		  2 : seg_data_r = i_data_store[11:8];
		  3 : seg_data_r = i_data_store[15:12];
		  4 : seg_data_r = i_data_store[19:16];
		  5 : seg_data_r = i_data_store[23:20];
		  6 : seg_data_r = i_data_store[27:24];
		  7 : seg_data_r = i_data_store[31:28];
		endcase
	 
	 reg [7:0] o_seg_r;
	 always @ (posedge clk, posedge reset)
	   if(reset)
		  o_seg_r <= 8'hff;
		else
		  case(seg_data_r)
		    4'h0 : o_seg_r <= 8'hC0;
          4'h1 : o_seg_r <= 8'hF9;
          4'h2 : o_seg_r <= 8'hA4;
          4'h3 : o_seg_r <= 8'hB0;
          4'h4 : o_seg_r <= 8'h99;
          4'h5 : o_seg_r <= 8'h92;
          4'h6 : o_seg_r <= 8'h82;
          4'h7 : o_seg_r <= 8'hF8;
          4'h8 : o_seg_r <= 8'h80;
          4'h9 : o_seg_r <= 8'h90;
          4'hA : o_seg_r <= 8'h88;
          4'hB : o_seg_r <= 8'h83;
          4'hC : o_seg_r <= 8'hC6;
          4'hD : o_seg_r <= 8'hA1;
          4'hE : o_seg_r <= 8'h86;
          4'hF : o_seg_r <= 8'h8E;
		  endcase
		  
	 assign o_sel = o_sel_r;
	 assign o_seg = o_seg_r;

endmodule
*/

module CPU54_dataflow(
    input clk,
    input rst,
    //input [15:0] sw,
    //output [31:0] o_addr
    //output [15:0] reg28
    output [31:0] inst
    //output [7:0] o_seg,
    //output [7:0] o_sel
    );
    wire clock,lock;
    wire rf_w,rf_clk,dm_cs,dm_r,dm_w,pc0,extsign,hi_ena,lo_ena,hi_we,lo_we,cp0_eret,cp0_exc,mfc0,mtc0;
    wire [3:0]  aluc;
    wire [22:0]  m;
    wire [4:0]  rsc,rtc,rdc;
    wire [31:0] imem_in,instr;
    wire zero,carry,negetive,overflow;
    wire [31:0] pc_in,pc_out,npc_out,rd,rs,rt,A,B,F,d_out,exc_addr,cp0_rdata,Lo_in,Hi_in,cp0_status;
    wire [31:0] m1_1,m6_0,m7_1,m4_1,m2_0;
    wire [31:0] m10_0,m11_0,m11_1,m12L_1,m12H_1,m15_0,m15_1,m16_0,m16_1,m17_0,m17_1,m19_1,m20_1,m21_1,m22_0,m22_1;
    wire [4:0]  m9_0,cp0_cause;
    wire [15:0] exam;
    wire [63:0] mul_out,multu_out,div_out,divu_out;
    wire [7:0] dmem_ctrl;
    divider     freqdiv(clk,clock,rst,lock);
    controller  CTRL(clock,instr[31:26],instr[5:0],instr,zero,rs[31],aluc,rf_w,rf_clk,dm_cs,dm_r,dm_w,m,rsc,rtc,hi_ena,lo_ena,hi_we,lo_we,cp0_eret,cp0_exc,mfc0,mtc0,pc0,extsign,cp0_cause,dmem_ctrl);
    npc         NPC(pc_out,npc_out);
    pc          PC(pc_in,clock,pc0,rst,pc_out);
    assign imem_in=pc_out-32'h00400000;
    //imem        IMEM({2'b00,imem_in[31:2]},instr);
    imem_ip     IMEM({2'b00,imem_in[31:2]},instr);
    regfile     RF(rsc,rtc,rdc,rd,rf_clk,rf_w,rst,rs,rt);//,exam);
    //assign reg28=exam;
    alu         ALU(A,B,aluc,F,zero,carry,negetive,overflow);
    dmem        DMEM(clock,rt,F,dm_w,dm_cs,rst,dmem_ctrl,d_out);
    ext16       EXT16(instr[15:0],extsign,m4_1);
    mux32       M1({pc_out[31:28],instr[25:0],2'b0},m1_1,m[1],m6_0);
    mux32       M2(m2_0,F,m[2],m7_1);
    mux32       M3({27'b0,instr[10:6]},rs,m[3],A);
    mux32       M4(rt,m4_1,m[4],B);
    mux32       M5({(instr[15]==0?14'b0:14'h3fff),instr[15:0],2'b0}+npc_out,npc_out,m[5],m1_1);
    mux32       M6(m6_0,rs,m[6],m10_0);
    mux32       M7((pc_out+32'd4),m7_1,m[7],m11_0);
    mux5        M8(instr[15:11],instr[20:16],m[8],m9_0);
    mux5        M9(m9_0,5'b11111,m[9],rdc);
    mux32       M10(m10_0,exc_addr,m[10],pc_in);
    mux32       M11(m11_0,m11_1,m[11],rd);
    mux32       M12_L(multu_out[31:0],m12L_1,m[12],m19_1);
    mux32       M12_H(multu_out[63:32],m12H_1,m[12],m20_1);
    mux32       M13(cp0_rdata,mul_out[31:0],m[13],m17_1);
    //mux32       M14();
    mux32       M15(div_out[63:32],divu_out[63:32],m[15],m12L_1);
    mux32       M16(divu_out[31:0],div_out[31:0],m[16],m12H_1);   
    mux32       M17(m17_0,m17_1,m[17],m11_1); 
    //mux32       M18();
    mux32       M19(rs,m19_1,m[19],Lo_in);
    mux32       M20(rs,m20_1,m[20],Hi_in);
    mux32       M21(d_out,m21_1,m[21],m2_0);
    mux32       M22(m22_0,m22_1,m[22],m21_1);
    hi_lo       HI(Hi_in,clock,hi_ena,hi_we,m22_1);
    hi_lo       LO(Lo_in,clock,lo_ena,lo_we,m22_0);
    cp0         CP0(clock,rst,mfc0,mtc0,pc_out,instr[15:11],rt,cp0_exc,cp0_eret,cp0_cause,cp0_rdata,cp0_status,exc_addr);
    clz         CLZ(rs,m17_0);
    mul         MUL(rs,rt,mul_out);
    //multu_ip    MULTU_IP(clock,rs,rt,multu_out);
    multu       MULTU(rs,rt,multu_out);
    wire t1,t2;
    div         DIV(1'b1,rt,1'b1,rs,t1,div_out);
    divu        DIVU(1'b1,rt,1'b1,rs,t2,divu_out);
    //wire seg7_cs;//switch_cs;
    //seg7x16     seg7(clock,rst,seg7_cs,rt,o_seg,o_sel);
    //sw_mem_sel  sw_mem(switch_cs,sw,d_out,rdata);
    //io_sel      io_mem(F,dm_cs,dm_w,dm_r,seg7_cs,switch_cs);
    //io_sel      io_mem(F,dm_cs,seg7_cs);
    //seg7x16     seg7(clock,rst,seg7_cs,rt,o_seg,o_sel);
    //assign o_addr=pc_out;
    //assign inst=instr;
endmodule
