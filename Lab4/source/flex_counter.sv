// $ID: $
// File name: $  
// Created:     $
// Author:      $
// Lab Section: $
// Version:     $
// Description: $


module flex_counter
#(
	NUM_CNT_BITS = 4
	    
)
(
	input wire clk,
	input wire n_rst,
	input wire clear,
	input wire count_enable,
	input wire [NUM_CNT_BITS-1:0] rollover_val,
	output wire [NUM_CNT_BITS-1:0] count_out,
	output wire rollover_flag
);

 //need the flags
  reg current_flag;
  reg next_flag;

  reg [NUM_CNT_BITS-1:0] current;
  reg [NUM_CNT_BITS-1:0] next;
	

//flipflop register	
always_ff @ (posedge clk, negedge n_rst) begin
    if( n_rst == 0) begin
      current <= '0;
      current_flag <= '0;     
    end
      
    else begin
      current <= next;
      current_flag <= next_flag;
    end
       
  end



//combb  next state
 always_comb  begin    
    if(clear == 1) begin
      next = '0;
      next_flag = '0;
    end
    
    else begin 
   
      if(count_enable == 1) begin      
        next = current + 1;
	//set nxt flag to zeroooo bitss
        next_flag = 1'b0;
        if(next== (rollover_val + 1)) begin
           next= 1;
          end

        if(next == rollover_val)
           next_flag = 1'b1;
          end
      
      else begin
	//set bits to zeroooo
        next_flag = 1'b0;
        next = current;
      end     
    end   
  end
  
  assign count_out = current;
  assign rollover_flag = current_flag;



endmodule


/*
`timescale 1ns /100ps

module adder_1bit
(
	input wire a,
	input wire b,
	input wire carry_in,
	
	output reg sum,
	output reg carry_out
);
 
always @ (a,b, carry_in)
   begin
      assert(( a == 1'b1) || (a == 1'b0))
      else $error("Input 'a' of component is not a digital logic value");

      assert((b == 1'b1) || (b == 1'b0))
      else $error("Input 'b' of component is not a digital logic value");

      assert((carry_in == 1'b1) || (carry_in == 1'b0))
      else $error("Input 'carry_in' of component is not a digital logic value");
	
   end



  assign sum = carry_in ^ (a ^ b);
  assign carry_out = ((! carry_in) & b & a) | (carry_in & (b | a));


   
   always @ (a, b, carry_in)
   begin
     #(2) assert (((a+b+carry_in)%2) == sum)
       else $error("Output 's' of first 1 bit adder is not correct");
   end
	

endmodule
`timescale 1ns /100ps

module adder_1bit
(
	input wire a,
	input wire b,
	input wire carry_in,
	
	output reg sum,
	output reg carry_out
);
 
always @ (a,b, carry_in)
   begin
      assert(( a == 1'b1) || (a == 1'b0))
      else $error("Input 'a' of component is not a digital logic value");

      assert((b == 1'b1) || (b == 1'b0))
      else $error("Input 'b' of component is not a digital logic value");

      assert((carry_in == 1'b1) || (carry_in == 1'b0))
      else $error("Input 'carry_in' of component is not a digital logic value");
	
   end



  assign sum = carry_in ^ (a ^ b);
  assign carry_out = ((! carry_in) & b & a) | (carry_in & (b | a));


   
   always @ (a, b, carry_in)
   begin
     #(2) assert (((a+b+carry_in)%2) == sum)
       else $error("Output 's' of first 1 bit adder is not correct");
   end
	

endmodule

*/