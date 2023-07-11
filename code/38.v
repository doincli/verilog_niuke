`timescale 1ns/1ns
module seller1(
	input wire clk  ,
	input wire rst  ,
	input wire d1 ,
	input wire d2 ,
	input wire d3 ,
	
	output reg out1,
	output reg [1:0]out2
);
//*************code***********//
parameter IDLE = 2'd0;
parameter S1 = 2'd1;
parameter S2 = 2'd2;

reg [1:0] state_c;
reg [1:0] state_n;
wire idl2s1_start;
wire s12s2_start;
wire s22idl_start;
wire idl2s2_start;		
wire s12idl_start;		
wire [2:0] data_in;	

assign data_in = {d3,d2,d1};
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
			else if (idl2s2_start) begin
				state_n = S2;
			end
			else if (d3== 1) begin
				state_n = IDLE;
			end
			else begin
				state_n = state_n;
			end
		end
		S1:begin
			if(s12s2_start)begin
				state_n = S2;
			end
			else if (s12idl_start) begin
				state_n = IDLE;
			end
			else begin
				state_n = state_n;
			end
		end
		S2:begin
			if(s22idl_start)begin
				state_n = IDLE;
			end
			else begin
				state_n = state_n;
			end
		end
		default:begin
			state_n = IDLE;
		end
	endcase
end
					
//第三段：设计转移条件
assign idl2s1_start  = state_c==IDLE && data_in == 3'b001 ;
assign idl2s2_start  = state_c==IDLE && data_in == 3'b010 ;

assign s12s2_start = state_c==S1    && data_in == 3'b001 ;
assign s12idl_start = state_c==S1    && (data_in == 3'b100 || data_in == 3'b010) ;
assign s22idl_start  = state_c==S2    && (d1 || d2 || d3) ;

reg [1:0] out2_tmp;
reg out1_tmp;

//第四段：同步时序always模块，格式化描述寄存器输出（可有多个输出）
always  @(posedge clk or negedge rst)begin
	if(!rst)begin
		out1_tmp <=1'b0;      //初始化
		out2_tmp <= 0;
	end
	else begin
		case (state_c)
		IDLE:begin
			if (d3 == 1) begin
				out1_tmp <= 1'b1;
				out2_tmp <= 1;
			end
			else begin
				out1_tmp <= 1'b0;
				out2_tmp <= 0;	
			end
		end
		S1:begin
			if (d3 == 1) begin
				out1_tmp <= 1'b1;
				out2_tmp <= 2;
			end
			else if (d2 == 1) begin
				out1_tmp <= 1'b1;
				out2_tmp <= 0;
			end
			else begin
				out1_tmp <= 1'b0;
				out2_tmp <= 0;	
			end
		end
		S2:begin
			if (d3 == 1) begin
				out1_tmp <= 1'b1;
				out2_tmp <= 3;
			end
			else if (d2 == 1) begin
				out1_tmp <= 1'b1;
				out2_tmp <= 1;
			end
			else if(d1 == 1)begin
				out1_tmp <= 1'b1;
				out2_tmp <= 0;	
			end
		end
			
		endcase
	end
end


always  @(posedge clk or negedge rst)begin
	if(rst==1'b0)begin
		out1 <= 0;
		out2 <= 0;
	end
	else begin
		out1 <= out1_tmp;
		out2 <= out2_tmp;	
	end
end
//*************code***********//
endmodule

