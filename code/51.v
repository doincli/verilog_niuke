`timescale 1ns/1ns

module count_module(
	input clk,
	input rst_n,
	input set,
	input [3:0] set_num,
	output reg [3:0]number,
	output reg zero
	);

    //有问题 需要打一拍 就离谱
    wire add_cnt;
    wire end_cnt;
    reg [3:0]cnt;                   
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt <= 0;
        end
        else if(add_cnt)begin
            if(end_cnt)
                cnt <= 0;
            else if(set)
                cnt <= set_num;
            else
                cnt <= cnt + 1;
        end
    end
                        
    assign add_cnt = 1;  
    assign end_cnt = add_cnt && cnt== 15; 

    //开始有一个 零输出 tip
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            zero <= 0;
        end
        else if(cnt == 0) begin
            zero <= 1;
        end
        else begin
            zero <= 0;
        end 
    end

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            number <= 0;
        end
        else begin
            number <= cnt;
        end
    end

endmodule