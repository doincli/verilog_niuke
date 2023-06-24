`timescale 1ns/1ns

module seq_circuit(
      input                A   ,
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
wire idl2s3_start;
wire s12s2_start;
wire s12idl_start;
wire s22s3_start;
wire s22s1_start;
wire s32idl_start;
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
            else if(idl2s3_start)begin
                state_n = S3;
            end
            else begin
                state_n = state_c;
            end
        end
        S1:begin
            if(s12s2_start)begin
                state_n = S2;
            end
            else if(s12idl_start)begin
                state_n = IDLE;
            end
            else begin
                state_n = state_c;
            end
        end
        S2:begin
            if(s22s3_start)begin
                state_n = S3;
            end
            else if(s22s1_start)begin
                state_n = S1;
            end
            else begin
                state_n = state_c;
            end
        end
        S3:begin
            if(s32s2_start)begin
                state_n = S2;
            end
            else if(s32idl_start)begin
                state_n = IDLE;
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
assign idl2s1_start  = state_c==IDLE && A ==0;
assign idl2s3_start  = state_c==IDLE && A == 1;
assign s12s2_start = state_c==S1    && A ==0;
assign s12idl_start = state_c==S1    && A ==1;
assign s22s3_start  = state_c==S2    && A ==0;
assign s22s1_start  = state_c==S2    && A ==1;
assign s32idl_start  = state_c==S3    && A ==0;
assign s32s2_start  = state_c==S3    && A ==1;

assign Y = (state_c == 2'b11) ? 1 : 0;



endmodule


