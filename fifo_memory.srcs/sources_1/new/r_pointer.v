`timescale 1ns / 1ps
module r_pointer(
input re,rst,clk,fifo_empty,
output reg [4:0] rptr
    );
    always @(posedge clk or negedge rst) begin
        if (!rst)begin
               rptr<=0;
               end
        else if (re && !fifo_empty) begin
            rptr<=rptr+1;
            end
        else
            rptr<=rptr;
       end
endmodule
