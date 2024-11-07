`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2024 21:54:27
// Design Name: 
// Module Name: Carry_Look_Ahead_Adder
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


module Carry_Look_Ahead_Adder  #(parameter N=16,M=4) (  //2^n bit adder    M= 2^n / 4 
            input [N-1:0] a, b,
            output[N:0] sum
    );
    generate 
    genvar i;
    wire [M-1:0] carry_holder;
    for (i=0;i<=M;i=i+1) begin 
      localparam integer min_index = 4*i;
      localparam integer max_index = min_index +3 ;
            if(i==0) begin
        four_bit_Full_Adder adder (a[max_index:min_index],b[max_index:min_index],1'b0,carry_holder[i],sum[max_index:min_index]);
            end
            else begin 
            four_bit_Full_Adder adder (a[max_index:min_index],b[max_index:min_index],carry_holder[i-1],carry_holder[i],sum[max_index:min_index]);
            end
       end
    endgenerate
    assign sum[N]= carry_holder[M-1];

endmodule
module Full_Adder(
    input a, b, carry_in,
    output reg sum, 
    output reg carry_out
);
    always @(*) begin 
        case ({a, b, carry_in}) 
            3'b000: begin
                sum = 1'b0;
                carry_out = 1'b0;
            end
            3'b001: begin
                sum = 1'b1;
                carry_out = 1'b0;
            end
            3'b010: begin
                sum = 1'b1;
                carry_out = 1'b0;
            end
            3'b011: begin
                sum = 1'b0;
                carry_out = 1'b1;
            end
            3'b100: begin
                sum = 1'b1;
                carry_out = 1'b0;
            end
            3'b101: begin
                sum = 1'b0;
                carry_out = 1'b1;
            end
            3'b110: begin
                sum = 1'b0;
                carry_out = 1'b1;
            end
            3'b111: begin
                sum = 1'b1;
                carry_out = 1'b1;
            end
            default: begin
                sum = 1'b0;       
                carry_out = 1'b0; 
            end
        endcase
    end
endmodule

module four_bit_Full_Adder(
    input [3:0] a, b,
    input carry_in,
    output carry_out, 
    output [3:0] sum 
);
    wire g0, g1, g2, g3, p0, p1, p2, p3 , c0, c1, c2;     

  
    assign g0 = a[0] & b[0];
    assign p0 = a[0] ^ b[0];
    assign c0 = g0 | (p0 & carry_in);
    
    assign g1 = a[1] & b[1];
    assign p1 = a[1] ^ b[1];
    assign c1 = g1 | (p1 & c0);
    
    assign g2 = a[2] & b[2];
    assign p2 = a[2] ^ b[2];
    assign c2 = g2 | (p2 & c1);
    
    assign g3 = a[3] & b[3];
    assign p3 = a[3] ^ b[3];
    assign carry_out = g3 | (p3 & c2);

   
    wire [3:0] carry_array = {c2, c1, c0, carry_in};
    wire dummy; 
    

    generate 
        genvar i;
        for (i = 0; i < 4; i = i + 1) begin : addition
            Full_Adder temp ((a[i]),(b[i]),(carry_array[i]), (sum[i]), (dummy));
        end
    endgenerate 
endmodule
