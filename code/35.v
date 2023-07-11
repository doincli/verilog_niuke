`timescale 1ns/1ns

module sequence_test1(
	input wire clk  ,
	input wire rst  ,
	input wire data ,
	output reg flag
);
//*************code***********//

parameter IDLE = 3'd0;
parameter S1 = 3'd1;
parameter S2 = 3'd2;
parameter S3 = 3'd3;
parameter S4 = 3'd4;
parameter S5 = 3'd5;

reg [2:0] state_c;
reg [2:0] state_n;
wire idl2s1_start;
wire s12s2_start;
wire s22s3_start;
wire s32s4_start;
wire s42s5_start;                    
//第一段：同步时序always模块，格式化描述次态寄存器迁移到现态寄存器(不需更改）
always@(posedge clk or negedge rst)begin
    if(!rst)begin
        state_c <= IDLE;
    end
    else begin
        state_c <= state_n;
    end
end
                    
//第二段：组合逻辑always模块，描述状态转移条件判断
always@(*)begin
    case(state_c)
        IDLE:begin
            if(idl2s1_start)begin
                state_n = S1;
            end
            else begin
                state_n = state_c;
            end
        end
        S1:begin
            if(s12s2_start)begin
                state_n = S2;
            end
            else begin
                state_n = IDLE;
            end
        end
        S2:begin
            if(s22s3_start)begin
                state_n = S3;
            end
            else begin
                state_n = IDLE;
            end
        end
        S3:begin
            if(s32s4_start)begin
                state_n = S4;
            end
            else begin
                state_n = IDLE;
            end
        end
        S4:begin
            if(s42s5_start)begin
                state_n = S5;
            end
            else begin
                state_n = IDLE;
            end
        end
        default:begin
            state_n = IDLE;
        end
    endcase
end
                    
//第三段：设计转移条件
assign idl2s1_start  = state_c==IDLE && data == 1;
assign s12s2_start = state_c==S1    && data == 0 ;
assign s22s3_start  = state_c==S2    && data == 1;
assign s32s4_start  = state_c==S3    && data == 1;
assign s42s5_start  = state_c==S4    && data == 1;                   

//第四段：同步时序always模块，格式化描述寄存器输出（可有多个输出）
always  @(posedge clk or negedge rst)begin
    if(!rst)begin
        flag <=1'b0;      //初始化
    end
    else if(s42s5_start)begin
        flag <= 1'b1;
    end
    else begin
        flag <= 1'b0;
    end
end

//*************code***********//
endmodule