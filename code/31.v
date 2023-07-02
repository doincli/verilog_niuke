`timescale 1ns/1ns

module valid_ready(
	input 				clk 		,   
	input 				rst_n		,
	input		[7:0]	data_in		,
	input				valid_a		,
	input	 			ready_b		,
 
 	output		 		ready_a		,
 	output	reg			valid_b		,
	output  reg [9:0] 	data_out
);

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        out <= 0;
    end
    else begin
    end
end



endmodule