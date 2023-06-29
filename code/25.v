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


always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        match <= 0;
    end 
    else if (tmp == 9'b01110001) begin
        match <= 1;
    end
    else begin
        match <= 0;
    end
end
  
endmodule