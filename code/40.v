`timescale 1ns/1ns

module odo_div_or
   (
    input    wire  rst ,
    input    wire  clk_in,
    output   wire  clk_out7
    );

//*************code***********//
reg [2:0] count_p; //上升沿计数
reg [2:0] count_n; //下降沿计数
reg clk_p; //上升沿分频
reg clk_n; //下降沿分频

always  @(posedge clk_in or negedge rst)begin
    if(rst==1'b0)begin
        count_p <= 0;
    end
    else if (count_p == 6 ) begin
        count_p <= 0;
    end
    else begin
        count_p <= count_p + 1;
    end
end

always  @(negedge clk_in or negedge rst)begin
    if(rst==1'b0)begin
        count_n <= 0;
    end
    else if (count_n == 6 ) begin
        count_n <= 0;
    end
    else begin
        count_n <= count_n + 1;
    end
end

always  @(posedge clk_in or negedge rst)begin
    if(rst==1'b0)begin
        clk_p <= 0;
    end
    else if (count_p == 2 || count_p == 5  ) begin
        clk_p <= ~clk_p;
    end
    else begin
        clk_p <= clk_p;
    end
end

always  @(negedge clk_in or negedge rst)begin
    if(rst==1'b0)begin
        clk_n <= 0;
    end
    else if (count_n == 2 || count_n == 5  ) begin
        clk_n <= ~clk_n;
    end
    else begin
        clk_n <= clk_n;
    end
end

assign clk_out7 = clk_n | clk_p;
//*************code***********//
endmodule