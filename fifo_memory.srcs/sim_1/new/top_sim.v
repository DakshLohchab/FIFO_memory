`timescale 1ns / 1ps
`timescale 1ns/1ps

module top_sim;

reg clk;
reg rst;
reg we;
reg re;
reg [7:0] data_in;

wire [7:0] data_out;
wire fifo_full;
wire fifo_empty;
wire fifo_overflow;
wire fifo_underflow;
wire fifo_threshold;


// DUT INSTANTIATION

top DUT(
    .clk(clk),
    .rst(rst),
    .we(we),
    .re(re),
    .data_in(data_in),

    .data_out(data_out),
    .fifo_full(fifo_full),
    .fifo_empty(fifo_empty),
    .fifo_overflow(fifo_overflow),
    .fifo_underflow(fifo_underflow),
    .fifo_threshold(fifo_threshold)
);


// CLOCK GENERATION

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end


// TEST SEQUENCE

initial begin

    // INITIAL VALUES
    rst = 1;
    we = 0;
    re = 0;
    data_in = 0;

    // RESET
    #20;
    rst = 0;

    // WRITE DATA INTO FIFO

    #10;
    we = 1;

    data_in = 8'h11; #10;
    data_in = 8'h22; #10;
    data_in = 8'h33; #10;
    data_in = 8'h44; #10;
    data_in = 8'h55; #10;
    data_in = 8'h66; #10;
    data_in = 8'h77; #10;
    data_in = 8'h88; #10;
    data_in = 8'h99; #10;

    we = 0;

    // READ DATA FROM FIFO

    #20;

    re = 1;

    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;
    #10;

    re = 0;

    // UNDERFLOW TEST

    #20;
    re = 0;
    #10;
    re = 1;

    // OVERFLOW TEST

    #20;
    we = 1;

    repeat(20) begin
        data_in = data_in + 1;
        #10;
    end

    we = 0;

    #50;

    $finish;

end


// MONITOR SIGNALS

initial begin
    $monitor(
        "TIME=%0t rst=%b we=%b re=%b data_in=%h data_out=%h full=%b empty=%b overflow=%b underflow=%b",
        $time,
        rst,
        we,
        re,
        data_in,
        data_out,
        fifo_full,
        fifo_empty,
        fifo_overflow,
        fifo_underflow
    );
end

endmodule