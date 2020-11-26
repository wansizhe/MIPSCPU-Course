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
endmodule

module controller(
    input clk,
    input [5:0] op,
    input [5:0] func,
    input [31:0] format,
    input z, //ALU的Z端
    //output pc_clk,
    //output im_r,
    output [3:0] aluc,
    output rf_w,
    output rf_clk,
    output dm_cs,
    output dm_r,
    output dm_w,
    output [9:0] m,
    output [4:0] rsc,
    output [4:0] rtc,
    //output [4:0] rdc,
    output pc0,
    output extsign
    );
    wire r_type=~|op;
    wire i_add=r_type&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
    wire i_addu=r_type&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&func[0];
    wire i_sub=r_type&func[5]&~func[4]&~func[3]&~func[2]&func[1]&~func[0];
    wire i_subu=r_type&func[5]&~func[4]&~func[3]&~func[2]&func[1]&func[0];
    wire i_and=r_type&func[5]&~func[4]&~func[3]&func[2]&~func[1]&~func[0];
    wire i_or=r_type&func[5]&~func[4]&~func[3]&func[2]&~func[1]&func[0];
    wire i_xor=r_type&func[5]&~func[4]&~func[3]&func[2]&func[1]&~func[0];
    wire i_nor=r_type&func[5]&~func[4]&func[3]&~func[2]&func[1]&~func[0];
    wire i_slt=r_type&func[5]&~func[4]&~func[3]&~func[2]&~func[1]&~func[0];
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
    
    //assign pc_clk=clk;
    //assign im_r=1;
    assign aluc[3]=i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_slti|i_sltiu|i_lui;
    assign aluc[2]=i_and|i_or|i_xor|i_nor|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_andi|i_ori|i_xori;
    assign aluc[1]=i_add|i_sub|i_xor|i_nor|i_slt|i_sltu|i_sll|i_sllv|i_addi|i_xori|i_lw|i_sw|i_beq|i_bne|i_slti|i_sltiu;
    assign aluc[0]=i_sub|i_subu|i_or|i_slt|i_nor|i_srl|i_srlv|i_ori|i_beq|i_bne|i_slti;
    assign rf_w=i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_slti|i_sltiu|i_lui|i_jal;
    assign rf_clk=clk;//(i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_slti|i_sltiu|i_lui)&clk;
    assign dm_cs=i_lw|i_sw;
    assign dm_r=i_lw;
    assign dm_w=i_sw;
    assign m[0]=0;
    assign m[1]=i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_sw|i_beq|i_bne|i_slti|i_sltiu|i_lui;
    assign m[2]=i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_slti|i_sltiu|i_lui;
    assign m[3]=i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_sw|i_beq|i_bne|i_slti|i_sltiu;
    assign m[4]=i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_sw|i_slti|i_sltiu|i_lui;
    assign m[5]=i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_sw|i_beq&~z|i_bne&z|i_slti|i_sltiu|i_lui;
    assign m[6]=i_jr;
    assign m[7]=i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav|i_jr|i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_slti|i_sltiu|i_lui;
    assign m[8]=i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_slti|i_sltiu|i_lui;
    assign m[9]=i_jal;
    assign rsc[4:0]=format[25:21];
    assign rtc[4:0]=format[20:16];
    //assign rdc[4:0]=(i_add|i_addu|i_sub|i_subu|i_subu|i_and|i_or|i_xor|i_nor|i_slt|i_sltu|i_sll|i_srl|i_sra|i_sllv|i_srlv|i_srav)&format[15:11]|(i_addi|i_addiu|i_andi|i_ori|i_xori|i_lw|i_slti|i_sltiu|i_lui)&format[20:16];
    assign pc0=i_jr|i_j|i_jal;
    assign extsign=i_addi|i_addiu|i_lw|i_sw|i_slti|i_sltiu;
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
            temp=0;
        else
        begin
            if(pc0)
                temp=in;//-32'h00400000;
            else
                temp=in;
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
    input [31:0] datain,
    input [31:0] addr,
    input dm_w,
    input dm_r,
    input dm_cs,
    //input rst,
    output [31:0] dataout
    );
    reg [7:0] tab[0:1023];
    wire [31:0] addr0=addr;//-32'h10010000;
    reg [31:0] temp;
    //integer i;
    always @(posedge dm_cs)// or posedge rst)
    begin
        //if(rst)
          //  for(i=0;i<1024;i=i+1)
            //    tab[i]=8'b0;
        if(dm_r)
        begin
            temp={tab[addr0+3],tab[addr0+2],tab[addr0+1],tab[addr0]};
        end
        if(dm_w)
        begin
            tab[addr0]=datain[7:0];
            tab[addr0+1]=datain[15:8];
            tab[addr0+2]=datain[23:16];
            tab[addr0+3]=datain[31:24];
        end
    end
    assign dataout=temp;
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

module CPU31_dataflow(
    input clock,
    input rst,
    output [31:0] o_addr,
    output [31:0] inst
    );
    wire rf_w,rf_clk,dm_cs,dm_r,dm_w,pc0,extsign;
    wire [3:0]  aluc;
    wire [9:0]  m;
    wire [4:0]  rsc,rtc,rdc;
    wire [31:0] instr;
    wire zero,carry,negetive,overflow;
    wire [31:0] pc_in,pc_out,npc_out,rd,rs,rt,A,B,F,d_in,d_out;
    wire [31:0] m1_1,m6_0,m7_1,m4_1;
    wire [4:0]  m9_0;
    controller  CTRL(clock,instr[31:26],instr[5:0],instr,zero,aluc,rf_w,rf_clk,dm_cs,dm_r,dm_w,m,rsc,rtc,pc0,extsign);
    npc         NPC(pc_out,npc_out);
    pc          PC(pc_in,clock,pc0,rst,pc_out);
    //imem        IMEM({2'b00,pc_out[31:2]},instr);
    imem_ip     imemip({2'b00,pc_out[31:2]},instr);
  //iram_ip     iram(clock,1'b1,pc_out/4,instr);
    regfile     RF(rsc,rtc,rdc,rd,rf_clk,rf_w,rst,rs,rt);
    alu         ALU(A,B,aluc,F,zero,carry,negetive,overflow);
    dmem        DMEM(d_in,F,dm_w,dm_r,dm_cs,d_out);
    ext16       EXT16(instr[15:0],extsign,m4_1);
    mux32       M1({pc_out[31:28],instr[25:0],2'b0},m1_1,m[1],m6_0);
    mux32       M2(d_out,F,m[2],m7_1);
    mux32       M3({27'b0,instr[10:6]},rs,m[3],A);
    mux32       M4(rt,m4_1,m[4],B);
    mux32       M5({(instr[15]==0?14'b0:14'h3fff),instr[15:0],2'b0}+npc_out,npc_out,m[5],m1_1);
    mux32       M6(m6_0,rs,m[6],pc_in);
    mux32       M7((pc_out+32'd4+32'h00400000),m7_1,m[7],rd);
    mux5        M8(instr[15:11],instr[20:16],m[8],m9_0);
    mux5        M9(m9_0,5'b11111,m[9],rdc);
    assign o_addr=pc_out;
    assign inst=instr;
endmodule

