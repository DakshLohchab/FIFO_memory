`timescale 1ns / 1ps
module memory_array(
input re,we,clk,fifo_full,fifo_empty,
input [4:0] rptr,wptr,
input [7:0] data_in, output reg[7:0] data_out
    );
    reg [7:0] mem[15:0];
    always @(posedge clk) begin
    if (we && !fifo_full) begin
        mem[wptr[3:0]]<=data_in;
        end 
    if (re && !fifo_empty) begin
        data_out<=mem[rptr[3:0]];
        end
     end 
endmodule
