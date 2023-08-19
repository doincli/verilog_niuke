module handshake_sync ( 
    input clk1 , //快时钟信号
    input sys_rst_n , //复位信号，低电平有效
    input read , //信号，快时钟阈的
    input clk2 , //慢时钟信号

    output read_sync_pulse //输出信号
);

 //in1表示该信号在clk1时钟域
 reg req_in1 ;
 reg ack_in1 ;
 reg ack_in1_dly1 ;
 //in2表示该信号在clk2时钟域
 reg req_in2 ;
 reg req_in2_dly1 ;
 
 //*****************************************************
 //**                   main code
 //*****************************************************
 
 //1、clk1时钟域下req信号的生成
 always @(posedge clk1 or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) 
        req_in1 <= 1'b0;
    else if(read == 1'b1)
        req_in1 <= 1'b1;
    else if(ack_in1_dly1 == 1'b1)
        req_in1 <= 1'b0;
    else
        req_in1 <= 1'b0;
 end


 //2、clk2时钟域下req信号的采样
 always @(posedge clk2 or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        req_in2 <= 1'b0;
        req_in2_dly1 <= 1'b0;
    end
    else begin
        req_in2 <= req_in1;
        req_in2_dly1 <= req_in2;
    end
 end
 
 //3、clk1时钟域下ack信号的采样 直接采样req_in2_dly1作为ack信号即可
 //这是因为有了req_in2和req_in2_dly1之后我们就可以生成dout，所以此时就可以返回ack信号了
 always @(posedge clk1 or negedge sys_rst_n) begin
    if (sys_rst_n == 1'b0) begin
        ack_in1 <= 1'b0;
        ack_in1_dly1 <= 1'b0;
    end
        
    else begin
        ack_in1 <= req_in2_dly1 ;
        ack_in1_dly1 <= ack_in1;
    end
        
 end
 
 //4、dout信号的产生
 
 assign read_sync_pulse = req_in2 & ~req_in2_dly1;
 
 endmodule

/*
 always@(posedge clk_in or negedge rst_n) begin

if(rst_n==1'b0) d_reg<=1'b0;

else if (d_in==1'b1) d_reg<=1'b1;

else if (d_ack==1'b1) d_reg<=1'b0;

end

问题2：

assign dout=d_reg_sync && d_reg_sync_d;
*/