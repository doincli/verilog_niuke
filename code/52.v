`timescale 1ns/1ns

module count_module(
	input clk,
	input rst_n,
	input mode,
	output reg [3:0]number,
	output reg zero
	);


    wire add_cnt;
    wire end_cnt;
    reg [3:0] cnt;
                        
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
        else if(dec_cnt)begin
            if(dend_cnt)
                cnt <= 9;
            else
                cnt <= cnt - 1;
        end
    end
                        
    assign add_cnt = mode == 1;  
    assign end_cnt = add_cnt && cnt== 9; 

    assign dec_cnt = mode == 0;  
    assign dend_cnt = dec_cnt && cnt== 0; 

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            number <= 0;
        end
        else begin
            number <= cnt;
        end
    end

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            zero <= 0;
        end
        else if(cnt == 0)begin
            zero <= 1;
        end
        else begin
            zero <= 0;
        end
    end

endmodule