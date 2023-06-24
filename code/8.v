
`timescale 1ns/1ns

module gen_for_module(

    input [7:0] data_in,

    output [7:0] data_out

);

 

    generate

        genvar i;

        for(i = 0; i <8; i=i+1)

            begin:assign_test//名字随便起，但是必须有

                assign data_out[i] = data_in[7 - i];

            end

    endgenerate

 

endmodule
