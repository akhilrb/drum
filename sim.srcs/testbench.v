`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2019 11:40:21 AM
// Design Name: 
// Module Name: testbench
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testbench #(parameter TEST_RESOLUTION=4, TEST_WIDTH=8) ();

reg [TEST_WIDTH-1 : 0] A, B;
wire [2*TEST_WIDTH-1 : 0] product;
reg clk, reset;
integer i, j;

approxMultiplier #(.MAIN_RESOLUTION(TEST_RESOLUTION), .MAIN_WIDTH(TEST_WIDTH)) ApproxMultiplier(A, B, product, clk, reset);

initial begin
    reset = 1'b1; #2 reset = 1'b0; #18;
    for(i=10; i<20; i=i+2)
    begin
        for(j=10; j<20; j=j+1)
        begin
            A = i; B = j;
            clk = 1'b1; #5;
            clk = 1'b0; #5;
        end
    end
    $finish;   
end
endmodule
