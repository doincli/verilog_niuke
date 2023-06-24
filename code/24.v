`timescale 1ns/1ns
module edge_detect(
	input clk,
	input rst_n,
	input a,
	
	output reg rise,
	output reg down
);
	reg a_tmp;

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            a_tmp <= 0;
        end
        else begin
            a_tmp <= a;
        end
    end

    //rise
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            rise <= 0;
        end
        else if (a == 1 && a_tmp == 0) begin
            rise <= 1;
        end
        else begin
            rise <= 0;
        end
    end


    //down
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            down <= 0;
        end
        else if (a == 0 && a_tmp == 1) begin
            down <= 1;
        end
        else begin
            down <= 0;
        end
    end
endmodule