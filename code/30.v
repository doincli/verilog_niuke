`timescale 1ns/1ns

module s_to_p(
	input 				clk 		,   
	input 				rst_n		,
	input				valid_a		,
	input	 			data_a		,
 
 	output	reg 		ready_a		,
 	output	reg			valid_b		,
	output  reg [5:0] 	data_b
);

wire add_cnt;
wire end_cnt;
reg [2:0] cnt;
reg [5:0] tmp;                    
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
                    
assign add_cnt = valid_a;  
assign end_cnt = add_cnt && cnt== 5; 

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        ready_a <= 0;
    end
    else begin
        ready_a <= 1;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        tmp <= 0;
    end
    else if(valid_a) begin
        tmp <= {data_a,tmp[5:1]};
    end
    else begin
        tmp <= tmp;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_b <= 0;
    end
    else if (end_cnt) begin
        data_b <= {data_a,tmp[5:1]};
    end
    else begin
        data_b <= data_b;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        valid_b <= 0;
    end
    else if (end_cnt) begin
        valid_b <= 1;
    end
    else begin
        valid_b <= 0;
    end
end


endmodule