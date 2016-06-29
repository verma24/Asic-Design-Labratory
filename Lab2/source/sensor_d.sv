// $Id: $
// File name:   sensor_d.sv
// Created:     1/22/2016
// Author:      Rishab Verma
// Lab Section: 337-05
// Version:     1.0  Initial Design Entry
// Description: 1.2.2 lab 02

module sensor_d
(
	input wire [3:0] sensors,
	output wire error
);

wire int_and1;
wire int_and2;
wire int_or1;

assign int_and1 = sensors[3] & sensors[1];
assign int_and2 = sensors[2] & sensors[1];
assign int_or1 = int_and1 | int_and2;
assign error = int_or1 | sensors[0];
endmodule
