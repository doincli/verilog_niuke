`timescale 1ns/1ns

module count_module(
	input clk,
	input rst_n,

    output reg [5:0]second,
    output reg [5:0]minute
	);
	
	                    
    wire add_cnt0;
    wire end_cnt0;

    wire add_cnt1;
    wire end_cnt1;

                        
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            second <= 0;
        end
        else if(add_cnt0)begin
            if(end_cnt0)
                second <= 1;
            else if (minute == 60)
                second <= 0;
            else
                second <= second + 1;
        end
    end
                        
    assign add_cnt0 = 1 ;
    assign end_cnt0 = add_cnt0 && second== 60;
                        
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            minute <= 0;
        end
        else if(add_cnt1)begin
            if(end_cnt1)
                minute <= 60;
            else
                minute <= minute + 1;
        end
    end
                        
    assign add_cnt1 = end_cnt0;
    assign end_cnt1 = add_cnt1 && minute== 60 ;
	
endmodule