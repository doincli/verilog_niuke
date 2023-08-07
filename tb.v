`include "a.v" 
`timescale 1 ns/1 ns
                    
module aa_tb();
                    
//时钟和复位
reg clk  ;
reg rst_n;
                    
                
wire[7:0] cnt;                    
                    
//时钟周期，单位为ns，可在此修改时钟周期。
parameter CYCLE    = 20;
                    
//复位时间，此时表示复位3个时钟周期的时间。
parameter RST_TIME = 3 ;
                    
alu u1(
  .clk          (clk     ), 
  .rst_n        (rst_n   ),
  .cnt          (cnt    )                          
);                 
   
initial #1000000 $finish;
                    
                    
//生成本地时钟50M
initial begin
  clk = 0;
  forever
  #(CYCLE/2)
  clk=~clk;
end
                    
//产生复位信号
initial begin
  rst_n = 1;
  #2;
  rst_n = 0;
  #(CYCLE*RST_TIME);
  rst_n = 1;
end

 initial
    begin            
        $dumpfile("wave.vcd");
        $dumpvars(0,aa_tb);
    end                   
                    
//待测试的模块例化

endmodule