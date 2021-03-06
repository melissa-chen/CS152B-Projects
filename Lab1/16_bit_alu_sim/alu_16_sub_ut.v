`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2017 04:44:15 AM
// Design Name: 
// Module Name: alu_16_sub_ut
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

module alu_16_sub_ut;

    /*
     * UUT inputs.
     */
    reg[15:0] a;
    reg[15:0] b;
    reg [3:0] ctrl;

    /*
     * UUT outputs.
     */
    wire zero;
    wire [15:0] s;
    wire overflow;

    /*
     * Instantiate the Unit Under Test (UUT).
     */
    alu_control uut (.a(a),
                     .b(b),
                     .ctrl(ctrl),
                     .overflow(overflow),
                     .zero(zero),
                     .s(s));

    /**
     * Defines a procedure for evaluating a single test case.
     * 
     * @param a Input operand a.
     * @param b Input operand b.
     */
    task testcase;
        input [15:0] op_a;
        input [15:0] op_b;

        begin
            a = op_a;
            b = op_b;

            /*
             * Delay of 5 ticks after setting operands to observe result.
             */
            #5;
        end
    endtask

    /**
     * All of the test cases.
     */
    task run_tests;

        begin
            /*
             * Verify subtractive identity.
             */
            testcase(0, 0);
            testcase(1, 0);
            testcase(32767, 0);
            testcase(-32768, 0);

            /*
             * But, subtraction is not commutative.
             */
            testcase(0, 1);
            testcase(0, 32767);
            testcase(0, -32767);

            /*
             * General subtraction.
             */
            testcase(327, 16390);
            testcase(16384, 16383);
            testcase(1, 10922);
            testcase(-16384, 16384);
            testcase(-32760, -18297);
            testcase(-16384, -16383);
            testcase(-1, 2);
            testcase(0, -16383);
            testcase(-16383, -16384);

            /*
             * Subtraction overflow.
             *
             * The different should wrap around. Additionally, the ALU's
             * overflow output should go high for all subsequent test cases.
             */
            testcase(32767, -1);
            testcase(-32768, 1);
            testcase(0, -32768);
            testcase(32767, -32768);
            testcase(-32768, 32767);
        end
    endtask

    /**
     * Entry point for the unit test.
     */
    initial begin
        /*
         * Initialize operands to 0. Subtraction is selected using control code
         * 0.
         */
        a = 0;
        b = 0;
        ctrl = 0;

        /*
         * Enforce a short delay before tests begin.
         */
        #10

        /*
         * Run the tests.
         */
        run_tests;

        /*
         * Complete the simulation.
         */
        $finish;

        /*
         * Delay for global reset.
         */
        #100;
    end
endmodule
