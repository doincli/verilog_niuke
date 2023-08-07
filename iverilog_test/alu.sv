module alu(
clk    ,
rst_n  ,
//其他信号,举例dout
cnt
);
                    
//参数定义
parameter      DATA_W =         8;
                    
//输入信号定义
input               clk    ;
input               rst_n  ;
                    
//输出信号定义
output[DATA_W-1:0]  cnt   ;
                    
//输出信号reg定义
reg   [DATA_W-1:0]  cnt   ;
                    

wire add_cnt;
wire end_cnt;

                    
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
                    
assign add_cnt = 1;  
assign end_cnt = add_cnt && cnt== 30; 
                    
endmodule
