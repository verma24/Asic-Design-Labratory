// $Id: $
// File name:   $
// Created:     $
// Author:      $
// Description: $

module sync_high
(

	input wire clk,
	input wire n_rst,
	input wire async_in,
	output reg sync_out

);

	reg signal1;
	reg signal2;

	always_ff @ (posedge clk, negedge n_rst)
	begin : sync1
		if(1'b0 == n_rst)
		begin
			signal1 <= 1;
		end
		else
		begin
			signal1 <= async_in;
		end
	end

	always_ff @ (posedge clk, negedge n_rst)
	begin : sync2
		if(1'b0 == n_rst)
		begin
			signal2 <= 1;
		end
		else
		begin
			if( 1'b1 == signal1 ) 
			begin
				signal2 <= signal1;
			end
			else
			begin
				signal2 <= 0;
			end
		end	
	end
	assign sync_out = signal2;

endmodule
