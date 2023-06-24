
`timescale 1ns/1ns

module data_select(

    input clk,

    input rst_n,

    input signed[7:0]a,

    input signed[7:0]b,

    input [1:0]select,

    output reg signed [8:0]c

);

 

always @(posedge clk or negedge rst_n)

    if(!rst_n)

        c <= 9'd0;

    else case(select)

    2'b00:    c <= a;

    2'b01:    c <= b;

    2'b10:    c <= a+b;

    2'b11:    c <= a-b;

    default: c <= 9'd0;

    endcase

 

endmodule
