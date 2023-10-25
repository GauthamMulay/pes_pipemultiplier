`timescale 1ns/1ps
module pes_fpmul_tb;
reg clk=1'b0;
reg in_ready;
reg [10:0] a,b;
wire [10:0] product;
wire done;

fpmul uut(.clk(clk),.in_ready(in_ready),.a(a),.b(b),.product(product),.done(done));

always clk = #5 ~clk;

initial begin
$dumpfile("fpmul.vcd");
$dumpvars(0,pes_fpmul_tb);

in_ready=1'b1;
a=11'b1001_1111_000;
b=11'b0000_0101_110;

#50

a=11'b0010_0101_011;
b=11'b1010_1010_110;

#50

a=11'b1010_1111_110;
b=11'b1100_1011_010;
#200

$finish;
end
endmodule


