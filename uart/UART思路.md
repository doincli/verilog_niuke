# UART Verilog



## 输入输出

```verilog
module uart_rx#(
      parameter CLK_FRE = 80,
	  parameter BAUD_RATE = 115200
)

(
    clk    ,
    rst_n  ,
    rx_pin,
    po_data,
    po_flag
    );

    //参数定义
    localparam      DATA_W =         8;
    localparam     CYCLE = CLK_FRE *1000000 / BAUD_RATE; //波特率参数

```



## RX模块

### 打两拍防止亚稳态

```
//打两拍防止亚稳态   幔时钟域到快时钟域打拍子操作
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            rx_reg1 <= 0;
            rx_reg2 <= 0;
            rx_reg3 <= 0;
        end
        else begin
            rx_reg1 <= rx_pin;
            rx_reg2 <= rx_reg1;    
            rx_reg3 <= rx_reg2;      
        end
    end
```



### 边缘检测

```
    //边沿检测电路 检测起始位
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            start_nedge <= 0;
        end
        else if(rx_reg2 == 0 && rx_reg3 == 1 && work_en == 0) begin
            start_nedge <= 1;
        end
        else begin 
            start_nedge <= 0;
        end
    end
```



### 计算波特率

```verilog

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n || work_en == 0)begin
            baud_cnt <= 0;
        end
        else if(add_baud_cnt)begin
            if(end_baud_cnt)
                baud_cnt <= 0;
            else
                baud_cnt <= baud_cnt + 1;
        end
    end

    assign add_baud_cnt = work_en == 1 ;       
    assign end_baud_cnt = add_baud_cnt && baud_cnt==  CYCLE - 1;  


    //采样时钟使能标志位
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            bit_flag <= 0;
        end
        else if(baud_cnt ==CYCLE/2 )begin
            bit_flag <= 1;
        end
        else begin 
            bit_flag <= 0;
        end
    end


    //bit 计数器   记录传输到第几个bit 记9个就行了 停止位不需要记录时间
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            bit_cnt <= 0;
        end
        else if(add_bit_cnt)begin
            if(end_bit_cnt)
                bit_cnt <= 0;
            else
                bit_cnt <= bit_cnt + 1;
        end
    end

    assign add_bit_cnt = bit_flag ;       
    assign end_bit_cnt = add_bit_cnt && bit_cnt== 8 ;
```



### 存储数据

```
    //bit 计数器   记录传输到第几个bit 记9个就行了 停止位不需要记录时间
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            bit_cnt <= 0;
        end
        else if(add_bit_cnt)begin
            if(end_bit_cnt)
                bit_cnt <= 0;
            else
                bit_cnt <= bit_cnt + 1;
        end
    end

    assign add_bit_cnt = bit_flag ;       
    assign end_bit_cnt = add_bit_cnt && bit_cnt== 8 ;  


    //串行转换成并行 做移位处理
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            rx_data <= 0;
        end
        else if((bit_cnt >=1 && bit_cnt <=8)&&(bit_flag == 1)) begin
            rx_data <= {rx_reg3,rx_data[7:1]};
        end
    end
```



### 传输完成处理

```
    //数据接收完成标志位
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            rx_flag <= 0;
        end
        else if((bit_cnt ==8)&&(bit_flag == 1)) begin
            rx_flag <= 1;
        end
        else begin 
            rx_flag <= 0;
        end
    end
   

    //数据缓存完成可以输出标志位
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
             po_flag <= 0;
        end
        else begin
            po_flag <= rx_flag ;
        end
    end

    //数据接收完成缓存 
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin           
            po_data <= 0;
        end
        else if(rx_flag == 1) begin
            po_data <= rx_data ;
        end
    end

```



## tx模块

### 输入输出

```
module uart_tx#(
     parameter CLK_FRE = 80,
	 parameter BAUD_RATE = 115200
)
(
    clk    ,
    rst_n  ,
    pi_data,
    pi_flag,
    finish_flag,
    tx_pin
    );

```



### 使能

```
    //是能标志位
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            work_en <= 0;
        end
        else if(pi_flag == 1)begin
            work_en <= 1;
        end
        else if(bit_cnt == 10 && bit_flag == 1)begin 
            work_en <= 0;
        end
    end
```



### 计算波特率

```
    //波特率计数器
        always @(posedge clk or negedge rst_n)begin
        if(!rst_n || work_en == 0)begin
            baud_cnt <= 0;
        end
        else if(add_baud_cnt)begin
            if(end_baud_cnt)
                baud_cnt <= 0;
            else
                baud_cnt <= baud_cnt + 1;
        end
    end

    assign add_baud_cnt = work_en == 1 ;       
    assign end_baud_cnt = add_baud_cnt && baud_cnt==  CYCLE - 1; 

```



### 记录发送了几个

```
    //bit发送标志位
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            bit_flag <= 0;
        end
        else if(baud_cnt == 25) begin
            bit_flag <= 1;
        end
        else begin
            bit_flag <= 0;
        end
    end



     //bit 计数器   记录传输到第几个bit 停止位也要记录
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            bit_cnt <= 0;
        end
        else if(add_bit_cnt)begin
            if(end_bit_cnt)
                bit_cnt <= 0;
            else
                bit_cnt <= bit_cnt + 1;
        end
    end

    assign add_bit_cnt = bit_flag ;       
    assign end_bit_cnt = add_bit_cnt && bit_cnt== 10 ; 
```





### 发送模块

```
    //输出一个字节完成标志位
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            finish_flag <= 0;
        end
        else if(bit_cnt == 10) begin
            finish_flag <= 1; 
        end
        else begin 
            finish_flag <= 0;
        end
    end


    //tx的传输时序 基本的串口协议  一帧
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            tx_pin <= 1;
        end
        else if(bit_flag == 1)begin
            case(bit_cnt) 
 0       : tx_pin <= 1'b0;       //起始位
 1       : tx_pin <= pi_data[0];
 2       : tx_pin <= pi_data[1];
 3       : tx_pin <= pi_data[2];
 4       : tx_pin <= pi_data[3];
 5       : tx_pin <= pi_data[4];
 6       : tx_pin <= pi_data[5];
 7       : tx_pin <= pi_data[6];
 8       : tx_pin <= pi_data[7];
 9       : tx_pin <= 1'b1     ;    //停止位
default  : tx_pin <= 1'b1     ;       
            endcase
     
        end
    end
```





## top

### 输入输出

```
module uart_top(
    clk    ,    // 80_M
    rst_n1  ,
    rx_pin ,
    S1_data,
    S2_data,
    Number,
    tx_pin
    );

```



### 思路如下

1. 首先检测相位差点数，不为0开始发送
2. 边沿检测产生send信号，发给tx模块
3. tx发送完成，标志位拉高，然后继续发送，发送80次后一直拉低就好
4. 一次发送6字节数据 分别的EE + 是否对齐 +FF FF + 相差点数
5. 复位是接收到上位机的AB之后全部复位，重新发送该数据