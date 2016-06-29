// $Id: $
// File name:   $
// Created:     $
// Author:      $
// Description: $

`timescale 1ns /100ps

module adder_nbit
#(
	parameter BIT_WIDTH = 4
)
(
	input wire [(BIT_WIDTH-1):0] a,
	input wire [(BIT_WIDTH-1):0] b,
	input wire carry_in,
	
	output reg [(BIT_WIDTH-1):0] sum,
	output reg overflow
);
 
  wire [BIT_WIDTH:0] carrys;
  genvar i;
  genvar j;

  generate
	for (j = 0;j <= (BIT_WIDTH-1) ; j = j + 1)
	begin
           //adder_1bit IX (.a(a[i]), .b(b[i]), .carry_in(carrys[i]),.sum(sum[i]), .carry_out(carrys[i+1]));	
	   //1 bit adder result check
		always @ (a[j], b[j], carry_in )
		begin
			assert( (a[j] == 1'b1) || (a[j] == 1'b0) )
			else
			$error("Input 'a' component %d is not a digital logic ", j);
			
			
			assert( (b[j] == 1'b1) || (b[j] == 1'b0) )
			else
			$error("Input 'a' component %d is not a digital logic ", j);
			
			
			assert( (carry_in == 1'b1) || (carry_in == 1'b0) )
			else
			$error("Input 'carry_in' component %d is not a digital logic ");
			
				
		end		   
	end	
  	endgenerate



  assign carrys[0] = carry_in;
  generate
	for (i = 0;i <= (BIT_WIDTH-1) ; i = i + 1)
	begin
		adder_1bit IX (.a(a[i]), .b(b[i]), .carry_in(carrys[i]),.sum(sum[i]), .carry_out(carrys[i+1]));

	   //1 bit adder result check
		always @ (a[i], b[i], carrys[i] )
		begin
			#(2) assert( sum[i] ==1'b1 || sum[i] == 1'b0 )
			else
			$error("Sum %d is not a digital logic ", i);
			#(2) assert ( carrys[i+1] == 1'b1 || carrys[i+1] == 1'b0 )

			else
			$error("Carry_out bit at %d is not digital logic", i);	
		end		   
	end	
  	endgenerate

	assign overflow = carrys[BIT_WIDTH];

  
endmodule
