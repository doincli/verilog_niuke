`timescale 1ns/1ns

module comparator_4(
	input		[3:0]       A   	,
	input	   [3:0]		B   	,
 
 	output	 wire		Y2    , //A>B
	output   wire        Y1    , //A=B
    output   wire        Y0      //A<B
);

reg Y2_tmp,Y1_tmp,Y0_tmp;

wire Y2_out;
wire Y1_out;
wire Y0_out;

//Y2 out

always  @(*)begin
    if (Y2_out) begin
        Y2_tmp = 1;
    end else begin
        Y2_tmp = 0;
    end
end

always  @(*)begin
    if (Y1_out) begin
        Y1_tmp = 1;
    end else begin
        Y1_tmp = 0;
    end
end

always  @(*)begin
    if (Y0_out) begin
        Y0_tmp = 1;
    end else begin
        Y0_tmp = 0;
    end
end

assign Y2_out = A[3] > B[3] || (A[3] == B[3] && A[2] > B[2]) || (A[3] == B[3] && A[2] == B[2] && A[1] > B[1]) || (A[3] == B[3] && A[2] == B[2] && A[1] == B[1] && A[0] > B[0]);


assign Y1_out = (A[3] == B[3] && A[2] == B[2] && A[1] == B[1] && A[0] == B[0]);

assign Y0_out = !(Y2_out || Y1_out);


assign Y2 =Y2_tmp;
assign Y1 = Y1_tmp;
assign Y0 = Y0_tmp;

endmodule