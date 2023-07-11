`timescale 1ns/1ns
module ram_mod(
	input clk,
	input rst_n,
	
	input write_en,
	input [7:0]write_addr,
	input [3:0]write_data,
	
	input read_en,
	input [7:0]read_addr,
	output reg [3:0]read_data
);
	reg [3:0] ram [7:0];

    //wri
    integer ii;
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            for (ii = 0; ii < 8; ii = ii + 1) begin
                ram[ii] <= 0;
            end
        end
        else begin
            if (write_en) begin
                ram[write_addr] <= write_data;
            end
        end
    end

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            read_data <= 0;
        end
        else if(read_en) begin
            read_data <= ram[read_addr];
        end
    end

    
endmodule