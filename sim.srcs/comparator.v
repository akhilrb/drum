`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/09/2019 03:50:14 PM
// Design Name: 
// Module Name: comparator
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


module comparator #(parameter WIDTH=8) (
    input [$clog2(WIDTH):0] comp_a,
    input [WIDTH-1:0] comp_b,
    output a_is_greater
    );
    
    assign a_is_greater = (comp_a > comp_b) ? 1 : 0;
endmodule
