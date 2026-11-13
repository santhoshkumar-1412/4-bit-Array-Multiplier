`timescale 1ns/1ps
module ha(output s,c,input a,b);
assign s = a^b;
assign c = a&b;
endmodule
module fa(output s,cout, input a,b,cin);
assign s = a^b^cin;
assign cout =(a&b)|(b&cin)|(cin&a);
endmodule
module bit4_array_multiplier(output [7:0]p,input [3:0]a,b);
wire [3:0]pp0,pp1,pp2,pp3;
wire [3:0]s1,s2,s3;
wire [3:0]c1,c2,c3;
assign pp0 = a & {4{b[0]}};
assign pp1 = a & {4{b[1]}};
assign pp2 = a & {4{b[2]}};
assign pp3 = a & {4{b[3]}};
//1st stage 
assign p[0] = pp0[0];
ha h1 (s1[0],c1[0],pp0[1],pp1[0]);
fa f1 (s1[1],c1[1],pp0[2],pp1[1],c1[0]);
fa f2 (s1[2],c1[2],pp0[3],pp1[2],c1[1]);
fa f3 (s1[3],c1[3],1'b0,pp1[3],c1[2]);
//2nd stage
ha h2 (s2[0],c2[0],s1[1],pp2[0]);
fa f4 (s2[1],c2[1],s1[2],pp2[1],c2[0]);
fa f5 (s2[2],c2[2],s1[3],pp2[2],c2[1]);
fa f6 (s2[3],c2[3],c1[3],pp2[3],c2[2]);
//3rd stage
ha h3 (s3[0],c3[0],s2[1],pp3[0]);
fa f7 (s3[1],c3[1],s2[2],pp3[1],c3[0]);
fa f8 (s3[2],c3[2],s2[3],pp3[2],c3[1]);
fa f9 (s3[3],c3[3],c2[3],pp3[3],c3[2]);
assign p[1] = s1[0];
assign p[2] = s2[0];
assign p[3] = s3[0];
assign p[4] = s3[1];
assign p[5] = s3[2];
assign p[6] = s3[3];
assign p[7] = c3[3];
endmodule
