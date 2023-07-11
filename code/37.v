`timescale 1ns/1ns

module even_div
    (
    input     wire rst ,
    input     wire clk_in,
    output    wire clk_out2,
    output    wire clk_out4,
    output    reg[2:0] cnt,
    output    wire clk_out8
    );
//*************code***********//

wire add_cnt;
wire end_cnt;
//reg [2:0] cnt;
                    
always @(posedge clk_in or negedge rst)begin
    if(!rst)begin
        cnt <= 3'b111;
    end
    else if(add_cnt)begin
        if(end_cnt)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
end
                    
assign add_cnt = 1;  
assign end_cnt = add_cnt && cnt== 7; 

assign clk_out2 = !cnt[0];
assign clk_out4 = !cnt[1];
assign clk_out8 = !cnt[2];



//*************code***********//
endmodule