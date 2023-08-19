`timescale 1 ns/1 ns
                    
module tb();
                    
//时钟和复位
reg clk1  ;
reg clk2  ;
reg rst_n;
                    
//uut的输入信号

reg       sig1  ;
                    
                    
//uut的输出信号
wire      sig2;
                    
//时钟周期，单位为ns，可在此修改时钟周期。
parameter CYCLE    = 20;
                    
//复位时间，此时表示复位3个时钟周期的时间。
parameter RST_TIME = 3 ;
                    
//待测试的模块例化
pulse_syn u1(
    .clk1(clk1), //异步慢时钟
    .in(sig1), //异步信号
    .rst_n(rst_n), //复位信号
    .clk2(clk2), //目的快时钟域市政
    .out(sig2)
    ); 
                    
                    
//生成本地时钟50M
initial begin
    clk1 = 0;
    forever
    #(CYCLE/2)
    clk1=~clk1;
end


initial begin
    clk2 = 0;
    forever
    #(CYCLE*2)
    clk2=~clk2;
end


//产生复位信号
initial begin
    rst_n = 1;
    #2;
    rst_n = 0;
    #(CYCLE*RST_TIME);
    rst_n = 1;
end

wire add_cnt;
wire end_cnt;
reg [2:0] cnt;
                    
always @(posedge clk1 or negedge rst_n)begin
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
assign end_cnt = add_cnt && cnt== 5; 

always  @(posedge clk1 or negedge rst_n)begin
    if(rst_n==1'b0)begin
        sig1 <= 0;
    end
    else if (cnt == 4) begin
        sig1 <= 1;
    end
    else begin
        sig1 <= 0;
    end
end


initial                  
begin 
    $dumpfile("wave.vcd"); //生成波形文件vcd的名称 
    $dumpvars(0, tb); //tb模块名称
end

initial 
begin
    #(5208*20*3000); 
    $finish;
end                   
                    
endmodule