`timescale 1ns / 1ps
module w_pointer(
input we,rst,clk,fifo_full,
output reg[4:0] wptr
    );
    always @(posedge clk or negedge rst) begin
        if (!rst) begin
            wptr<=0;
            end
        else if (we && !fifo_full) begin
            wptr<=wptr+5'b00001;
            end
        else 
            wptr<=wptr;
        end
endmodule
