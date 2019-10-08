`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2019 04:19:41 PM
// Design Name: 
// Module Name: barrelShifter
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


module barrelShifter #(parameter IN_WIDTH = 4, OUT_WIDTH = 8) (
    input [IN_WIDTH-1 : 0] dataIn,
    input [$clog2(OUT_WIDTH):0] shiftAmount,    // shift amount wouldn't cross beyond log(OUT_WIDTH)
    output [OUT_WIDTH-1 : 0] shiftedOut
    );

    // barrel shifting -> combinational logic -> no clock dependency   
    assign shiftedOut = dataIn << shiftAmount;

endmodule
