`timescale 1 ns/1 ns
module top_test;

reg			clk;
reg 		rst_n;
reg			wr_en;
reg[15:0]	data_in;
reg			rd_en;
wire		full;
wire		empty;
wire       	data_out;
sys_fifo u1
(
	.clk	 (clk),
	.rst_n   (rst_n),
	.wr_en   (wr_en),
	.data_in (data_in),
	.rd_en   (rd_en),
	.full    (full),
	.data_out (data_out),
	.empty   (empty)
);

//时钟周期，单位为ns，可在此修改时钟周期。
parameter CYCLE    = 20;
					
//复位时间，此时表示复位3个时钟周期的时间。
parameter RST_TIME = 3 ;

//生成本地时钟50M
initial begin
	clk = 0;
	forever
	#(CYCLE/2)
	clk=~clk;
end
					
//产生复位信号
initial begin
	rst_n = 1;
	#2;
	rst_n = 0;
	#(CYCLE*RST_TIME);
	rst_n = 1;
end

initial begin
wr_en = 1;
end


always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		data_in <= 3;
	end
	else begin
		data_in <= data_in + 1;
	end
end

initial begin
rd_en = 0;
#(CYCLE*RST_TIME + 50);
rd_en = 1;
#10;
rd_en = 0;
end
endmodule

					
					
