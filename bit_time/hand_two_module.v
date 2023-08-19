`timescale 1ns/1ns
module data_driver(
	input clk_a,
	input rst_n,
	input data_ack,
	output reg [3:0]data,
	output reg data_req
	);

reg data_ack1;
reg data_ack2;
wire add_flag;
always  @(posedge clk_a or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_ack1 <= 0;
        data_ack2 <= 0;
    end
    else begin
        data_ack1 <= data_ack;
        data_ack2 <= data_ack1;
    end
end

assign add_flag = ~data_ack1 && data_ack2;

always  @(posedge clk_a or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data <= 0;
    end
    else if(add_flag) begin
        data <= data + 1;
    end
    else begin
        data <= data;
    end
end

wire add_cnt;
wire end_cnt;
reg [2:0] cnt;
                    
always @(posedge clk_a or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(add_flag)begin
        cnt <= 0;
    end
    else if(add_cnt)begin
        if(end_cnt)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
end
                    
assign add_cnt = 1;  
assign end_cnt = add_cnt && cnt== 4; 

always  @(posedge clk_a or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_req <= 0;
    end
    else if (cnt == 4) begin
        data_req <= 1;
    end
    else if(add_flag) begin
        data_req <= 0;
    end
end

endmodule


module data_receiver(
clk_b    ,
rst_n  ,
//其他信号,举例dout
data ,
data_ack,
data_req
);
                    

                    
//输入信号定义
input               clk_b    ;
input               rst_n  ;
input     [3:0]     data   ;  
input               data_req;                          
//输出信号定义
output   data_ack           ;

reg data_req1;
reg data_req2;
reg [3:0] data_in_reg;
wire receiver_flag;
reg   data_ack           ;
always  @(posedge clk_b or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_req1 <= 0;
        data_req2 <= 0;
    end
    else begin
        data_req1 <= data_req;
        data_req2 <= data_req1;
    end
end


assign receiver_flag = ~data_req1 && data_req2;

always  @(posedge clk_b or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_in_reg <= 0;
    end
    else if (receiver_flag) begin
        data_in_reg <= data;    
    end
    else begin
        data_in_reg <= data_in_reg;  
    end
end

always  @(posedge clk_b or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_ack <= 0;
    end
    else if (data_req1) begin
        data_ack <= 1;    
    end
    else begin
        data_ack <= 0; 
    end
end
                    
endmodule