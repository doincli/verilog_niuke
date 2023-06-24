
`timescale 1ns/1ns

 

module data_cal(

input clk,

input rst,

input [15:0]d,

input [1:0]sel,

 

output [4:0]out,

output validout

);

//*************code***********//

 

//wire declaration

 

//reg declaration

reg [15:0] tmp;

reg valid;

reg [4:0] signal_out;

 

//有效信号

always  @(posedge clk or negedge rst)begin

    if(rst==1'b0)begin

        valid <= 0;

    end

    else if(0==sel) begin

        valid <= 0;

    end

    else begin

        valid <= 1;

    end

end

 

assign validout = valid;

 

//数据缓存

always  @(posedge clk or negedge rst)begin

    if(rst==1'b0)begin

         tmp <= 0;

    end

    else if(0==sel) begin

         tmp <= d;

    end

end

 

//信号输出

always  @(posedge clk or negedge rst)begin

    if(rst==1'b0)begin

       signal_out <= 0;

    end

    else begin

        case(sel)

            2'd0: signal_out <= 0;

            2'd1: signal_out <= tmp[3:0] + tmp[7:4];

            2'd2: signal_out <= tmp[3:0] + tmp[11:8];

            2'd3: signal_out <= tmp[3:0] + tmp[15:12];

        endcase

    end

end

 

assign out =signal_out;

 

//*************code***********//

endmodule

 

 
