 
`timescale 1ns/1ns
 
module function_mod(
    input [3:0]a,
    input [3:0]b,
    input clk,
    input rst_n,
    output [3:0]c,
    output [3:0]d
);
 
assign c = rever(a);
assign d = rever(b);
 
function [3:0] rever;
input [    3: 0]     datain    ;
integer i;
for(i=0; i <4; i++)
begin:revers
rever[i] = datain[3-i];
end
endfunction
 
endmodule