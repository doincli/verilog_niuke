module pulse_syn(
    input clk1,
    input clk2,
    input rst_n,
    input in,
    output out 
);
reg [3:0] reg_clk1;
wire reg_clk1_pos;
always  @(posedge clk1)begin
    if(rst_n==1'b0)begin
        reg_clk1 <= 0;
    end
    else begin
        reg_clk1 <= {reg_clk1[2:0],in};
    end
end

assign reg_clk1_pos = |reg_clk1;

reg [2:0] reg_clk2;
always  @(posedge clk2)begin
    if(rst_n==1'b0)begin
        reg_clk2 <= 0;
    end
    else begin
        reg_clk2 <= {reg_clk2[1:0],reg_clk1_pos};
    end
end

assign out = ~reg_clk2[2] && reg_clk2[1];

endmodule