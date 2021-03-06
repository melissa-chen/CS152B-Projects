`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/16/2017 10:40:50 AM
// Design Name: 
// Module Name: register_16_bit
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

/**
 * A synchronous 16-bit register.
 *
 * @input wrEn Register write enable.
 * @input busIn Input bus (for writing to the register).
 * @input clk Clock signal.
 * @input rst Global reset signal.
 * @output busOut Output bus (for reading from the register).
 */
module register_16_bit(wrEn, busIn, clk, rst, busOut);

/**
 * Define inputs.
 *
 * @{
 */
input wrEn;
input [15:0] busIn;
input clk;
input rst;
/**
 * @}
 */

/**
 * Define outputs.
 */
output [15:0] busOut;

/**
 * The actual register.
 */
reg [15:0] val;

assign busOut = val;

/*
 * Initialize the register to a value of 0.
 */
initial begin
    val <= 0;
end

always @ (posedge clk)
begin : LATCH
    /*
     * Reset assertions take global priority and should immediately set the
     * register value to 0.
     */
    if (rst) begin
        val <= 16'b0000_0000_0000_0000;
    end

    /*
     * If there is a concurrent read and write operation, the register output
     * value should reflect the write value in the same cycle (pass-through).
     */ 
    else if (wrEn) begin
        val <= busIn;
    end
end
endmodule
