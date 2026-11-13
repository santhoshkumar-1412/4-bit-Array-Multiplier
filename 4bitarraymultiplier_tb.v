`timescale 1ns/1ps
module bit4_array_multiplier_tb;
wire [7:0]p;
reg [3:0]a,b;
bit4_array_multiplier dut (.p(p),.a(a),.b(b));
initial 
begin
  $dumpfile("4bitarraymultiplier.fsdb");
  $dumpvars(0,bit4_array_multiplier_tb);
  $monitor("Time=%0t A=%d B=%d Product=%d",$time,a,b,p);
a=4'b0010;b=4'b0011;
#10;
a=4'b0100;b=4'b0101;
#10;
a=4'b0111;b=4'b0010;
#10;
a=4'b1001;b=4'b1010;
#10;
a=4'b1111;b=4'b1111;
#10
$finish;
end
endmodule
