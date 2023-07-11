`timescale 1ns/1ns

module width_8to12(
	input 				   clk 		,   
	input 			      rst_n		,
	input				      valid_in	,
	input	[7:0]			   data_in	,
 
 	output  reg			   valid_out,
	output  reg [11:0]   data_out
);

reg[11:0] tmp;
wire add_cnt;
wire end_cnt;
reg [2:0] cnt;
                    
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt <= 0;
    end
    else if(add_cnt)begin
        if(end_cnt)
            cnt <= 0;
        else
            cnt <= cnt + 1;
    end
end
                    
assign add_cnt = valid_in;  
assign end_cnt = add_cnt && cnt== 2; 

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        tmp <= 0;
    end
    else begin
        tmp <= {tmp[3:0],data_in};
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        valid_out <= 0;
    end
    else if((cnt == 2 || cnt == 1)&&valid_in)begin
        valid_out <= 1;
    end
    else begin
        valid_out <= 0;
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        data_out <= 0;
    end
    else if (cnt == 1 && valid_in) begin
        data_out <= {tmp[7:0],data_in[7:4]};
    end
    else if (cnt == 2 && valid_in) begin
        data_out <= {tmp[3:0],data_in};
    end
end

endmodule