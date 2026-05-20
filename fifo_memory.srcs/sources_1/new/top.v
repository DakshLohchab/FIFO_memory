`timescale 1ns / 1ps
module top(
input clk,rst,we,re,
input [7:0] data_in,
output fifo_empty,fifo_full,fifo_overflow,fifo_underflow,fifo_threshold,
output [7:0] data_out
    );
    wire [4:0] wptr,rptr;
    // wirte pointer
    w_pointer wp(.we(we),.rst(rst),.clk(clk),.fifo_full(fifo_full),.wptr(wptr));
    r_pointer rp(.re(re),.rst(rst),.clk(clk),.fifo_empty(fifo_empty),.rptr(rptr));
    memory_array ma(.re(re),.we(we),.clk(clk),.data_in(data_in),.fifo_full(fifo_full),
    .fifo_empty(fifo_empty),.rptr(rptr),.wptr(wptr),.data_out(data_out));
    status st(.re(re),.we(we),.wptr(wptr),.rptr(rptr),.fifo_full(fifo_full),.fifo_empty(fifo_empty),.fifo_overflow(fifo_overflow),.fifo_underflow(fifo_underflow),
    .fifo_threshold(fifo_threshold));   
endmodule
