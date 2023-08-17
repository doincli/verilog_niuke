module sys_fifo #(
    parameter WIDTH = 16,
    parameter DEPTH = 16,
    parameter ADDR_WIDTH = 4
) (
     input  clk,
     input  rst_n,
     input [WIDTH-1:0] data_in,
     input wr_en,
     input rd_en,
     output reg [WIDTH-1:0] data_out,
     output  full,
     output  empty   
);
    
reg [WIDTH-1:0] fifo [DEPTH-1:0];
reg [ADDR_WIDTH:0] cnt ;
reg [ADDR_WIDTH-1:0] wr_addr ;
reg [ADDR_WIDTH-1:0] rd_addr ;


always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        wr_addr <= 0;
    end
    else if (!full && wr_en) begin
        wr_addr <= wr_addr+1;
    end
    else begin
        wr_addr <= wr_addr;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        rd_addr <= 0;
    end
    else if (!empty && rd_en) begin
        rd_addr <= rd_addr+1;
    end
    else begin
        rd_addr <= rd_addr;
    end
end

integer  i;
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        for (i = 0; i < DEPTH; i = i + 1) begin
                fifo[i] <= 0;
        end
    end
    else if (!full && wr_en) begin
        fifo[wr_addr] <= data_in;
    end
    else begin
        fifo[wr_addr] <= fifo[wr_addr];
    end
end

//du
always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_out <= 0;
    end
    else if (!empty && rd_en) begin
        data_out <= fifo[rd_addr];
    end
    else begin
        data_out <= 0;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        cnt <= 0;
    end
    else if (!empty && rd_en && !wr_en) begin
        cnt <= cnt - 1;
    end
    else if (!full && wr_en && !rd_en) begin
        cnt <= cnt + 1;
    end
    else begin
        cnt <= cnt; 
    end
end

assign full = (cnt == DEPTH) ? 1: 0;
assign empty = (cnt == 0) ? 1:0;
                    
endmodule


 