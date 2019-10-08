`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2019 04:18:38 PM
// Design Name: 
// Module Name: encoder
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


module encoder #(parameter WIDTH = 8) (
        input [WIDTH-1:0] in,
        output reg [$clog2(WIDTH):0] out
    );
    
    integer i;
    always @ (in)
    begin
        out = 0;
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
