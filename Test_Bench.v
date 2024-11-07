`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.11.2024 22:39:46
// Design Name: 
// Module Name: Test_Bench
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


module Test_Bench(
    );
    reg [3:0] q,p;
    wire [4:0] sum4;
    Carry_Look_Ahead_Adder #(4,1) cal4 (p,q,sum4);
    reg [15:0] a,b;
    wire [16:0] sum;
    Carry_Look_Ahead_Adder #(16,4) cal (a,b,sum);
    reg [31:0] x,y;
    wire [32:0] sum32;
    Carry_Look_Ahead_Adder #(32,8) cal32 (x,y,sum32);
    
    
    initial begin 
        p=4'd15;
        q=4'd15;
        a=16'd120;
        b=16'd100;
        x=32'd1_000_000;
        y=32'd3_000_000;
        #10
        p=4'd15;
        q=4'd15;
        a=16'd12;
        b=16'd0;
        x=32'd100_000_000;
        y=32'd6_000_000;
        #10
         p=4'd15;
        q=4'd15;
         a=16'd60;
        b=16'd30;
        x=32'd 10;
        y=32'd 5;
        #10
         p=4'd15;
        q=4'd15;
        a=16'd25;
        b=16'd25;
        x=32'd4_294_967_295;
        y=32'd4_294_967_295;
     
        #10
         p=4'd15;
        q=4'd15;
         a=16'd120;
         b=16'd200;
         x=32'd 209_400;
            y=32'd  290_600;
            
        
        
    end
endmodule
