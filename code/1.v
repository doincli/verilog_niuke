
`timescale 1ns/1ns

module mux4_1(

input [1:0]d1,d2,d3,d0,

input [1:0]sel,

output[1:0]mux_out

);

//*************code***********//

    reg [1:0] mux_out_tmp;

    always@(*)begin

        case(sel)

            2'b00:mux_out_tmp = d3;

            2'b01:mux_out_tmp = d2;

            2'b10:mux_out_tmp = d1;

            2'b11:mux_out_tmp = d0;

        endcase

    end

            assign mux_out = mux_out_tmp;

 

//*************code***********//

endmodule
