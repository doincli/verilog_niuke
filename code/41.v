`timescale 1ns/1ns

module div_M_N(
 input  wire clk_in,
 input  wire rst,
 output wire clk_out
);
parameter M_N = 8'd87; 
parameter c89 = 8'd24; // 8/9时钟切换点
parameter div_e = 5'd8; //偶数周期
parameter div_o = 5'd9; //奇数周期
//*************code***********//
wire add_cnt;
wire end_cnt;
reg [8:0] cnt;
                    
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
assign end_cnt = add_cnt && cnt==86 ; 


//8fenpin
wire add_cnt1;
wire end_cnt1;
reg [2:0] cnt1;
                    
always @(posedge clk_in or negedge rst)begin
    if(!rst || cnt > c89 - 1)begin
        cnt1 <= 0;
    end
    else if(add_cnt1)begin
        if(end_cnt1)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 1;
    end
end
                    
assign add_cnt1 = 1;  
assign end_cnt1 = add_cnt1 && cnt1== 7; 


//9
wire add_cnt2;
wire end_cnt2;
reg [3:0] cnt2;
                    
always @(posedge clk_in or negedge rst)begin
    if(!rst || cnt < c89 )begin
        cnt2 <= 0;
    end
    else if(add_cnt2)begin
        if(end_cnt2)
            cnt2 <= 0;
        else
            cnt2 <= cnt2 + 1;
    end
end
                    
assign add_cnt2 =1 ;  
assign end_cnt2 = add_cnt2 && cnt2==8 ; 

reg clk_mn;
always  @(posedge clk_in or negedge rst)begin
    if(rst==1'b0)begin
        clk_mn <= 0;
    end
    else if(cnt < c89) begin
        if (cnt1 == 0 || cnt1 == 4) begin
            clk_mn <= ~clk_mn;
        end
    end
    else if (cnt >= c89) begin
        if (cnt2 == 0 || cnt2 == 4) begin
            clk_mn <= ~clk_mn;
        end
    end
end

assign clk_out = clk_mn;
//*************code***********//
endmodule