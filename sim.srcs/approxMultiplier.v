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
    input clock,
    input reset
);

wire [MAIN_RESOLUTION:0] truncA, truncB;
reg [$clog2(MAIN_WIDTH):0] loIndexA, loIndexB;
reg [(MAIN_RESOLUTION*2-1):0] resoluteProduct;
reg [MAIN_RESOLUTION:0] approxProduct;

// calculate leadOneIndex
lod #(.WIDTH(MAIN_WIDTH)) LOD_A(operandA, loIndexB);
lod #(.WIDTH(MAIN_WIDTH)) LOD_B(operandB, loIndexA);

// assign truncated values to be passed around
assign truncA = operandA[loIndexA -: MAIN_RESOLUTION];
assign truncB = operandB[loIndexB -: MAIN_RESOLUTION];

// To unbias the operands to the resolute multiplier
// the LSB in the selected k bits must be 1, so let's strap those values
assign truncA[0] = 1'b1;
assign truncB[0] = 1'b1;

// calculate the resolute product
multiplier #(.RESOLUTION(MAIN_RESOLUTION)) (truncA, truncB, resoluteProduct);

/*
The shift of the resoluteProduct is necessary to compensate for the offset.
Shift can be calculated by 

<-----n bits---->
|0|0|1|X|...|X|X|
    <---t bits-->
    <-k bits->

In the paper's terms, t-k bits need to be shifted for each operand, which results in
loIndexA + loIndexB - 2*MAIN_RESOLUTION
*/

assign shiftAmount = loIndexA + loIndexB - 2*MAIN_RESOLUTION;

// shift to produce approx product
barrelShifter #(.IN_DEPTH(MAIN_RESOLUTION), .OUT_DEPTH(MAIN_WIDTH)) BarrelShifter(resoluteProduct, shiftAmount, approxProduct);

endmodule

