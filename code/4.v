
`timescale 1ns/1ns

module multi_sel(

input [7:0]d ,

input clk,

input rst,

output reg input_grant,

output reg [10:0]out

);

//*************code***********//

 

//wire Declaration

wire add_cnt;

wire end_cnt;

 

//reg Declaration

reg [1:0] cnt;

reg [7:0] tmp;

 

 

//计数器

always @(posedge clk or negedge rst)begin

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

 

assign add_cnt = 1 ;     

assign end_cnt = add_cnt && cnt==3 ; 

 

//输出信号

always  @(posedge clk or negedge rst)begin

    if(rst==1'b0)begin

        input_grant <=0;

    end

    else if(cnt==0)begin

        input_grant <=1;

    end

    else begin

        input_grant <=0;

    end

end

 

//数据缓存

always  @(posedge clk or negedge rst)begin

    if(rst==1'b0)begin

        tmp <= 0;

    end

    else if(cnt==0) begin

         tmp <= d;

    end

end

 

//信号输出

always  @(posedge clk or negedge rst)begin

    if(rst==1'b0)begin

        out <= 0;

    end

    else begin

        case(cnt)

            2'b00:out <= d;

            2'b01:out <= (tmp<<1)+tmp;

            2'b10:out <= (tmp<<3)-tmp;

            2'b11:out <= (tmp<<3);

            default:out <=0;

        endcase

    end

end

 

//*************code***********//

endmodule

 

 
