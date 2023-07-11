`timescale 1ns/1ns

module valid_ready(
	input 				clk 		,   
	input 				rst_n		,
	input		[7:0]	data_in		,
	input				valid_a		,
	input	 			ready_b		,
 
 	output		 		ready_a		,
 	output	reg			valid_b		,
	output  reg [9:0] 	data_out
);

wire add_cnt;
wire end_cnt;
reg [2:0] cnt;
					
always @(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cnt <= 0;
	end
	else if(add_cnt)begin
		if(end_cnt)
			cnt <= 0;
		else
			cnt <= cnt + 1;
	end
end
					
assign add_cnt = valid_a & ready_a ;  
assign end_cnt = add_cnt && cnt== 3 ; 

assign ready_a = ~valid_b | ready_b;

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		valid_b <= 0;
	end
	else if(end_cnt )begin
		valid_b <= 1;
	end
	else if(add_cnt)begin
		valid_b <= 0;
	end	
end

always  @(posedge clk or negedge rst_n)begin
	if(rst_n==1'b0)begin
		data_out <= 0;
	end
	else if(add_cnt)begin
		if (cnt == 0) begin
			data_out <= data_in;
		end
		else begin
			data_out <= data_out + data_in;
		end
	end
end

endmodule