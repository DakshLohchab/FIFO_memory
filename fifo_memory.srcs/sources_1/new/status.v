`timescale 1ns / 1ps
module status(
input re,we,
input [4:0] wptr,rptr,
output fifo_full,fifo_empty,fifo_overflow,fifo_underflow,fifo_threshold
    );
    wire [4:0] fifo_count;
    assign fifo_empty = wptr==rptr;
    assign fifo_full = (wptr[4]!=rptr[4])&&(wptr[3:0]==rptr[3:0]);
    assign fifo_overflow = we&&fifo_full;
    assign fifo_underflow = re&&fifo_empty;
    assign fifo_count = wptr-rptr;
    assign fifo_threshold = fifo_count>=8;
endmodule
