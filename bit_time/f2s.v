module delay_clap(
  input  clk1, //异步慢时钟
  input    sig1, //异步信号

  input    rstn, //复位信号
  input    clk2, //目的快时钟域市政
  output   sig2); //快时钟域同步后的信号

 reg [2:0]  sig2_r ;  //3级缓存，前两级用于同步，后两节用于边沿检测
 always @(posedge clk2 or negedge rstn) begin
  if (!rstn) sig2_r <= 3'b0 ;
  else    sig2_r <= {sig2_r[1:0], sig1} ; //缓存
 end
 assign sig2 = sig2_r[1] && !sig2_r[2] ; //上升沿检测


endmodule