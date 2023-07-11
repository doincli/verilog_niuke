`timescale 1ns/1ns

module RAM_1port(
    input clk,
    input rst,
    input enb,
    input [6:0]addr,
    input [3:0]w_data,
    output wire [3:0]r_data
);
//*************code***********//

reg [3:0] memory1 [127:0];  

integer i;
always  @(posedge clk or negedge rst)begin
    if(rst==1'b0)begin
        for (i = 0 ; i < 128; i = i+1 ) begin
            memory1[i] <= 0;
        end
    end
    else begin
        if (enb) begin
            memory1[addr] =w_data;
        end
        else begin
            memory1[addr] = memory1[addr];
        end
    end
end

assign r_data = enb == 0 ? memory1[addr] : 0;
//*************code***********//
endmodule