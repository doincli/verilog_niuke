 
`timescale 1ns/1ns
 
module main_mod(
 
input clk,
 
input rst_n,
 
input [7:0]a,
 
input [7:0]b,
 
input [7:0]c,
 
output [7:0]d
 
);
 
 
 
//reg wire declaration
 
wire [7:0] tmp1;
 
reg [7:0] tmp2;
 
 
 
//buff c
 
always  @(posedge clk or negedge rst_n)begin
 
if(rst_n==1'b0)begin
 
tmp2 <= 0;
 
end
 
else begin
 
tmp2 <= c;
 
end
 
end
 
 
 
//模块调用
 
sub_mod u1(
 
.clk(clk),
 
.rst_n(rst_n),
 
.a(a),
 
.b(b),
 
.d(tmp1)
 
 
 
);
 
 
 
sub_mod u2(
 
.clk(clk),
 
.rst_n(rst_n),
 
.a(tmp1),
 
.b(tmp2),
 
.d(d)
 
);
 
 
 
 
 
endmodule
 
 
 
 
 
//子模块的编写
 
module sub_mod(
 
    input clk,
    
    input rst_n,
    
    input [7:0]a,
    
    input [7:0]b,
    
    output [7:0]d
 
);
 
 
 
reg [7:0] tmp;
 
 
 
always  @(posedge clk or negedge rst_n)begin
 
if(rst_n==1'b0)begin
 
tmp <= 0;
 
end
 
else if(a<b) begin
 
tmp <= a;
 
end
 
else begin
 
tmp <= b;
 
end
 
end
 
 
 
assign d = tmp ;
 
endmodule
 
 
 
 
 
 
 