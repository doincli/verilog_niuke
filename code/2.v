
`timescale 1ns/1ns

module Tff_2 (

input wire data, clk, rst,

output reg q

);

//*************code***********//

reg  tmp;

    always@(posedge clk or negedge rst)begin

        if(rst == 1'b0)begin

         tmp <= 0 ;

        end

        else begin

         tmp <= tmp ^ data;

        end

    end

 

     always@(posedge clk or negedge rst)begin

        if(rst == 1'b0)begin

         q <= 0 ;

        end

        else begin

         q <=tmp ^q;

        end

    end

//*************code***********//

endmodule
