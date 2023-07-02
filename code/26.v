`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input a,
	output reg match
	);

  reg [8:0] tmp;
//存储
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        tmp <= 0;
    end
    else  begin
        tmp <= {tmp[7:0],a};
    end
end

wire flag;
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        match <= 0;
    end 
    else if (flag) begin
        match <= 1;
    end
    else begin
        match <= 0;
    end
end

assign flag = tmp[8:6] == 3'b011 && tmp[2:0] == 3'b110;
endmodule