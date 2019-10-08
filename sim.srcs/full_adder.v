`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/08/2019 05:16:53 PM
// Design Name: 
// Module Name: full_adder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: half_adder.v
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module full_adder(
    input A,
    input B,
    input C,
    output Sum,
    output Carry
    );

     wire ha1_sum;
     wire ha2_sum;
     wire ha1_carry;
     wire ha2_carry;
     wire Sum;
     wire Carry;

     //half adder 1
    half_adder  ha1(
        .A(A),
        .B(B),
        .Sum(ha1_sum),
        .Carry(ha1_carry)
    );
    
    //half adder 2
    half_adder  ha2(
        .A(C),
        .B(ha1_sum),
        .Sum(ha2_sum),
        .Carry(ha2_carry)
    );

    assign Sum = ha2_sum;  
    assign Carry = ha1_carry | ha2_carry;
    
endmodule
