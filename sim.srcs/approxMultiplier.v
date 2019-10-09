`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2019 03:26:26 PM
// Design Name: 
// Module Name: approxMultiplier
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


module approxMultiplier #(parameter MAIN_RESOLUTION=4, MAIN_WIDTH=8) (
    input [MAIN_WIDTH-1:0] operandA,
    input [MAIN_WIDTH-1:0] operandB,
    output [2*MAIN_WIDTH-1:0] approxProduct,
    input clock,
    input reset
);

wire [MAIN_RESOLUTION-1:0] truncA, truncB;
wire [$clog2(MAIN_WIDTH):0] loIndexA, loIndexB;
wire [$clog2(2*MAIN_WIDTH):0] shiftAmount;
wire [(MAIN_RESOLUTION*2-1):0] resoluteProduct;
wire truncateOperandA, truncateOperandB;
integer i;
genvar x;

// calculate leadOneIndex
lod #(.WIDTH(MAIN_WIDTH)) LOD_A(operandA, loIndexA);
lod #(.WIDTH(MAIN_WIDTH)) LOD_B(operandB, loIndexB);

// the comparators will output whether there is a need to truncate the operands.
comparator #(.WIDTH(MAIN_WIDTH)) useApproxA(loIndexA+1, MAIN_RESOLUTION, truncateOperandA);
comparator #(.WIDTH(MAIN_WIDTH)) useApproxB(loIndexB+1, MAIN_RESOLUTION, truncateOperandB);

// assign truncated values to be passed around
for (x=(MAIN_RESOLUTION-1); x>0; x=x-1)
begin
    assign truncA[x] = (truncateOperandA) ? (operandA[loIndexA - (MAIN_RESOLUTION-1) + x]) : operandA[x];
    assign truncB[x] = (truncateOperandB) ? (operandB[loIndexB - (MAIN_RESOLUTION-1) + x]) : operandB[x];
end

// To unbias the operands to the resolute multiplier
// the LSB in the selected k bits must be 1, so let's strap those values
assign truncA[0] = (truncateOperandA) ? 1'b1 : operandA[0];
assign truncB[0] = (truncateOperandB) ? 1'b1 : operandB[0];

// calculate the resolute product
multiplier #(.RESOLUTION(MAIN_RESOLUTION)) smallMult(truncA, truncB, resoluteProduct);

/*
The shift of the resoluteProduct is necessary to compensate for the offset.
Shift can be calculated by 

<-----n bits---->
|0|0|1|X|...|X|X|
    <---t bits-->
    <-k bits->

In the paper's terms, t-k bits need to be shifted for each operand, which results in
(loIndexA+1) + (loIndexB+1) - 2*MAIN_RESOLUTION
*/

assign shiftAmount = (truncateOperandA) ? (truncateOperandB ? ((loIndexA+1) + (loIndexB+1) - 2*MAIN_RESOLUTION) : (loIndexA+1) - MAIN_RESOLUTION) : (truncateOperandB ? (loIndexB+1 - MAIN_RESOLUTION) : 0);

// shift to produce approx product
barrelShifter #(.IN_WIDTH(2*MAIN_RESOLUTION), .OUT_WIDTH(2*MAIN_WIDTH)) BarrelShifter(resoluteProduct, shiftAmount, approxProduct, clk, reset);

//// asynchronous reset
//always@(negedge reset)
//begin
//    for(i = 0; i < MAIN_WIDTH; i=i+1)
//        approxProduct[i] = 1'b0;
//end


endmodule
