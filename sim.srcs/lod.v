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
    output reg [$clog2(WIDTH):0] leadingOneOut
);

// for implementing FSM for the priority encoder
// tells the status of the encoder, whether the leading one is found 
reg found;

integer i;
always @ (negedge found)
begin
    begin
        for (i = WIDTH-1; i >= 0; i = i-1)
        // proceed only if leading one not yet 'found'
        if(found == 1'b0)
        begin
            if (in[i])
            begin
                leadingOneOut = i;
                $display("Found leading one at %d", i);
                // Essentially need to put a break here, which won't synthesize
                // which is precisely why an FSM is needed here.
                found = 1'b1;
            end
        end
    end
end

// change the value of 'found' once the input data changes
always@(in)
begin
    leadingOneOut = 0;
    found = 1'b0;
end

endmodule