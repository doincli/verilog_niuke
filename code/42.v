`timescale 1ns/1ns

module odd_div (    
    input     wire rst ,
    input     wire clk_in,
    output    wire clk_out5
);


reg [2:0] cnt;

always @ (posedge clk_in or negedge rst) begin
    if(~rst) begin
        cnt <= 3'b0;
    end

    else begin
        if(cnt == 3'd4) begin
        cnt <= 3'd0;
        end
        else begin
            cnt <= cnt + 3'd1;
        end
    end
end


reg clk_out5_r;
always @ (posedge clk_in or negedge rst) begin
    if(~rst) begin 
        clk_out5_r <= 3'b0;
    end
    else begin
        case( cnt )
            3'd0 : clk_out5_r <= 1'b1;
            3'd1 : clk_out5_r <= 1'b1;
            3'd2 : clk_out5_r <= 1'b0; 
            3'd3 : clk_out5_r <= 1'b0; 
            3'd4 : clk_out5_r <= 1'b0; 
            default : 
            clk_out5_r <= 1'b0;
        endcase
    end
end
assign clk_out5 = clk_out5_r;

endmodule