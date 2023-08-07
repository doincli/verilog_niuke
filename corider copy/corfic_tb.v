`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/31 19:54:51
// Design Name: 
// Module Name: corfic_tb
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


module corfic_tb(

   
    );

    reg [31:0]    x=32'h11120000;
    reg [31:0]    y=32'h11120000;
    reg           clk;
    wire [31:0]   phase;

initial begin
    clk=1'b1;
end
    always #5 clk=~clk;

    cordic_vec u_cordic(
        .x(x),
        .y(y),
        .clk(clk),
        . phase( phase)
    );


 initial
    begin            
        $dumpfile("wave.vcd");
        $dumpvars(0,corfic_tb);
    end    

initial #1000000 $finish;
endmodule
