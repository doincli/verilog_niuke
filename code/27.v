`timescale 1ns/1ns
module sequence_detect(
	input clk,
	input rst_n,
	input data,
	output reg match,
	output reg not_match
	);


    //计数器
    reg [2:0] cnt;
    always @(posedge clk or negedge rst_n) begin
       if (!rst_n) begin
            cnt <= 0;
       end 
       else begin
            if (cnt == 5) begin
                cnt <= 0;
            end
            else begin
                cnt <= cnt + 1;
            end
       end
    end

    reg [5:0] tmp;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            tmp <= 0;    
        end
        else begin
            tmp[5-cnt] <= data;
        end
    end

     always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            match <= 0;    
            not_match <= 0;
        end
        else if(tmp == 6'b011100 && cnt == 5) begin
            match <= 1;
            not_match <= 0;
        end
        else if(tmp != 6'b011100 && cnt == 5) begin
            match <= 0;
            not_match <= 1;
        end
        else begin
            match <= 0;    
            not_match <= 0;
        end
    end

endmodule