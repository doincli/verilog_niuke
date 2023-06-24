`timescale 1ns/1ns

module add (
    input  A,
    input  B,
    output P,
    output G
);

 assign   P = A ^ B;
 assign   G = B & A;

endmodule


module lca_4(
	input		[3:0]       A_in  ,
	input	    [3:0]		B_in  ,
    input                   C_1   ,
 
 	output	 wire			CO    ,
	output   wire [3:0]	    S
);
    
    wire [3:0] P;
    wire [3:0] G;

    generate
        genvar i;
        for(i = 0; i <4; i=i+1)
            begin:add//名字随便起，但是必须有
                add u1(
                    .A(A_in[i]),
                    .B(B_in[i]),
                    .P(P[i]),
                    .G(G[i])
                );
            end
    endgenerate

    wire [3:0] c;
    assign c[0] = C_1 & P[0] | G[0];
    assign c[1] = c[0] & P[1] | G[1];
    assign c[2] = c[1] & P[2] | G[2];
    assign c[3] = c[2] & P[3] | G[3];


    assign S[0] = P[0] ^ C_1;
    assign S[1] = P[1] ^ c[0];
    assign S[2] = P[2] ^ c[1];
    assign S[3] = P[3] ^ c[2];
     assign CO = c[3];
endmodule





//第二种解法

// `timescale 1ns/1ns

// module lca_4(
// 	input		[3:0]       A_in  ,
// 	input	    [3:0]		B_in  ,
//     input                   C_1   ,
 
//  	output	 wire			CO    ,
// 	output   wire [3:0]	    S
// );
    
//     wire [3:0] G;
//     wire [3:0] P;

// // 进位标志
//     assign G[0] = A_in[0] & B_in[0];
//     assign G[1] = A_in[1] & B_in[1];
//     assign G[2] = A_in[2] & B_in[2];
//     assign G[3] = A_in[3] & B_in[3];

// //位标志
//     assign P[0] = A_in[0] ^ B_in[0];
//     assign P[1] = A_in[1] ^ B_in[1];
//     assign P[2] = A_in[2] ^ B_in[2];
//     assign P[3] = A_in[3] ^ B_in[3];

//     wire [3:0] c;
//     assign c[0] = C_1 & P[0] | G[0];
//     assign c[1] = c[0] & P[1] | G[1];
//     assign c[2] = c[1] & P[2] | G[2];
//     assign c[3] = c[2] & P[3] | G[3];


//     assign S[0] = P[0] ^ C_1;
//     assign S[1] = P[1] ^ c[0];
//     assign S[2] = P[2] ^ c[1];
//     assign S[3] = P[3] ^ c[2];

//     assign CO = c[3];
// endmodule