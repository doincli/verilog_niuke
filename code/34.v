`timescale 1ns/1ns

module width_8to16(
	input 				   clk 		,   
	input 				   rst_n		,
	input				      valid_in	,
	input	   [7:0]		   data_in	,
 
 	output	reg			valid_out,
	output   reg [15:0]	data_out
);

wire add_cnt;
wire end_cnt;
reg [1:0] cnt;
                    
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
                    
assign add_cnt = valid_in;  
assign end_cnt = add_cnt && cnt== 1; 

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        valid_out <= 0;
    end
    else if(end_cnt)begin
        valid_out <= 1;
    end
    else begin
        valid_out <= 0;
    end
end

reg [15:0] tmp;
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        tmp <= 0;
    end
    else begin
        tmp <= {tmp[7:0],data_in};
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_out <= 0;
    end
    else if(end_cnt)begin
        data_out <= {tmp[7:0],data_in};
    end
end
endmodule