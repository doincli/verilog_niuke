`timescale 1ns/1ns

module clk_divider
    #(parameter dividor = 5)
( 	input clk_in,
	input rst_n,
	output clk_out
);
    
wire add_cnt;
wire end_cnt;
reg [5:0] cnt;
                    
always @(posedge clk_in or negedge rst_n)begin
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
                    
assign add_cnt = 1;  
assign end_cnt = add_cnt && cnt== 2*dividor - 1; 

always  @(posedge clk_in or negedge rst_n)begin
    if(rst_n==1'b0)begin
        clk_out <= 0;
    end
    else if(cnt == dividor - 1) begin
        clk_out <= 1;
    end
    else if (cnt == dividor * 2 -1) begin
        clk_out <= 0;
    end
end

endmodule