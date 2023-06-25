`timescale 1ns/1ns

module encoder_0(
   input      [8:0]         I_n   ,
   
   output reg [3:0]         Y_n   
);


always  @(*)begin
    casex (I_n)
    9'b0xxxxxxxx : Y_n = 4'b0110;
    9'b111111111 : Y_n = 4'b1111;
    9'b10xxxxxxx : Y_n = 4'b0111;
    9'b110xxxxxx : Y_n = 4'b1000;
    9'b1110xxxxx : Y_n = 4'b1001;
    9'b11110xxxx : Y_n = 4'b1010;
    9'b111110xxx : Y_n = 4'b1011;
    9'b1111110xx : Y_n = 4'b1100;
    9'b11111110x : Y_n = 4'b1101;
    9'b111111110 : Y_n = 4'b1110;
    endcase
end




endmodule