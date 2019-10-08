`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2019 04:19:41 PM
// Design Name: 
// Module Name: lod
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

// LOD is implemented along with a simple MSB to LSB priority encoder

module lod #(parameter WIDTH = 8) (
    input [WIDTH-1:0] in,
    output reg [$clog2(WIDTH):0] out
);

integer i;
always @ (in)
begin
    out = 0;
    // also encode the data for shifting
    for (i = WIDTH-1; i >= 0; i = i-1)
    begin
        if (in[i])
        begin
            out = i;
            break;
        end
    end
end

endmodule