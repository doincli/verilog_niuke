
`timescale 1ns/1ns

module odd_sel(

input [31:0] bus,

input sel,

output check

);

//*************code***********//

    reg tmp;

    always@(*)begin

        case(sel)

            1'b1:tmp = ^bus;

            1'b0:tmp = ~(^bus);

        endcase

    end

    assign check =tmp;

 

//*************code***********//

endmodule
