`timescale 1ns/1ns

module odd_div (    
    input     wire rst ,
    input     wire clk_in,
    output    wire clk_out5
);
//*************code***********//
wire add_cnt;
wire end_cnt;
reg [n:0] cnt;
                    
always @(posedge clk_in or negedge rst)begin
    if(!rst)begin
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
assign end_cnt = add_cnt && cnt==4; 

reg tmp;
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        tmp <= 0;
    end
    else if(cnt ==1 )begin
        tmp <= 1;
    end
    else if (cnt ==3) begin
        tmp <= 0;
    end
end

assign clk_out5 = tmp;


//*************code***********//
endmodule