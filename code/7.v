
`timescale 1ns/1ns

module data_minus(

    input clk,

    input rst_n,

    input [7:0]a,

    input [7:0]b,

 

    output  reg [8:0]c

);

 

always @(posedge clk or negedge rst_n)

    if(!rst_n)

        c <= 0;

    else if(a > b)

        c <= a-b;

    else

        c <= b-a;

endmodule
