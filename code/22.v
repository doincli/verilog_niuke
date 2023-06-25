`timescale 1ns/1ns

module seq_circuit(
   input                C   ,
   input                clk ,
   input                rst_n,
 
   output   wire        Y   
);


parameter IDLE = 2'd0;
parameter S1 = 2'd1;
parameter S2 = 2'd2;
parameter S3 = 2'd3;
reg [1:0] state_c;
reg [1:0] state_n;
wire idl2s1_start;
wire s12s3_start;
wire s22idl_start;
wire s32s2_start;                    
//第一段：同步时序always模块，格式化描述次态寄存器迁移到现态寄存器(不需更改）
always@(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        state_c <= IDLE;
        state_n <= IDLE;
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
            if(s12s3_start)begin
                state_n = S3;
            end
            else begin
                state_n = state_c;
            end
        end
        S2:begin
            if(s22idl_start)begin
                state_n = IDLE;
            end
            else begin
                state_n = state_c;
            end
        end
        S3:begin
            if(s32s2_start)begin
                state_n = S2;
            end
            else begin
                state_n = state_c;
            end
        end
        default:begin
            state_n = IDLE;
        end
    endcase
end
                    
//第三段：设计转移条件
assign idl2s1_start  = state_c==IDLE && C==1 ;
assign s12s3_start = state_c==S1    && C ==0;
assign s22idl_start  = state_c==S2    &&  C == 0;
assign s32s2_start  = state_c==S3    &&  C == 1;

//第四段：同步时序always模块，格式化描述寄存器输出（可有多个输出）
assign Y = (state_c==S3) || (state_c==S2 && C == 1);
// always  @(posedge clk or negedge rst_n)begin
//     if(rst_n==1'b0)begin
//         Y <= 0;
//     end
//     else if((state_c==S2) || (state_c==S3 && C == 1)) begin
//         Y <= 1;
//     end
//     else begin
//         Y <= 0;
//     end
// end
endmodule