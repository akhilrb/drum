`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2019 07:14:33 AM
// Design Name: 
// Module Name: multiplier
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies:  halfAdder.v & fullAdder.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

/*
@TO-DO
* How should I scale this?
* Is the only solution to a 16x16 multiplier hardcoded logic?
* Can 4-bit wallace-multipliers be instantiated to form a 4xP wallace multiplier?
* Testbench
*/

// implemented a 4-bit Wallace Tree Multiplier here
// would instantiate this object if scaling is required
module multiplier #(parameter RESOLUTION = 4) (
    input [(RESOLUTION-1):0] A,
    input [(RESOLUTION-1):0] B,
    output [((2*RESOLUTION)+1):0] out
    );
    
    // such a labyrinthine mess of wires
    wire s11,s12,s13,s14,s15,s22,s23,s24,s25,s26,s32,s33,s34,s35,s36,s37;
    wire c11,c12,c13,c14,c15,c22,c23,c24,c25,c26,c32,c33,c34,c35,c36,c37;
    wire [6:0] p0,p1,p2,p3;

    // initialize the products.
    assign  p0 = A & {4{B[0]}};
    assign  p1 = A & {4{B[1]}};
    assign  p2 = A & {4{B[2]}};
    assign  p3 = A & {4{B[3]}};

    // final product assignments    
    assign out[0] = p0[0];
    assign out[1] = s11;
    assign out[2] = s22;
    assign out[3] = s32;
    assign out[4] = s34;
    assign out[5] = s35;
    assign out[6] = s36;
    assign out[7] = s37;

    // first stage
    half_adder ha11 (p0[1],p1[0],s11,c11);
    full_adder fa12(p0[2],p1[1],p2[0],s12,c12);
    full_adder fa13(p0[3],p1[2],p2[1],s13,c13);
    full_adder fa14(p1[3],p2[2],p3[1],s14,c14);
    half_adder ha15(p2[3],p3[2],s15,c15);

    // second stage
    half_adder ha22 (c11,s12,s22,c22);
    full_adder fa23 (p3[0],c12,s13,s23,c23);
    full_adder fa24 (c13,c32,s14,s24,c24);
    full_adder fa25 (c14,c24,s15,s25,c25);
    full_adder fa26 (c15,c25,p3[3],s26,c26);

    // third stage
    half_adder ha32(c22,s23,s32,c32);
    half_adder ha34(c23,s24,s34,c34);
    half_adder ha35(c34,s25,s35,c35);
    half_adder ha36(c35,s26,s36,c36);
    half_adder ha37(c36,c26,s37,c37);

    // phew!

endmodule
