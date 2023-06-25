`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input data,
	input data_valid,
	output reg match
	);

    reg [3:0] tmp;

  always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        tmp <= 0;
    end
    else if(data_valid) begin
        tmp <= {tmp[2:0],data};
    end
  end


  always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        match <= 0;
    end
    else if(tmp[2:0] == 3'b011 && data_valid && data == 0) begin
        match <= 1;
    end
    else begin
        match <= 0;
    end
        
  end
endmodule