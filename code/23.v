`timescale 1ns/1ns
module rom(
	input clk,
	input rst_n,
	input [7:0]addr,
	
	output [3:0]data
);

reg [3:0] rom [7:0];

//4'd
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        rom[0] <= 0;
        rom[1] <= 2;
        rom[2] <= 4;
        rom[3] <= 6;
        rom[4] <= 8;
        rom[5] <= 10;
        rom[6] <= 12;
        rom[7] <= 14;
    end
end


assign data = rom[addr];

endmodule