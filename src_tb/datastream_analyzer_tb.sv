/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : datastream_analyzer_tb.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the testbench instiantiating the DUV and
              creating the simulation environment.

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`include "objections_pkg.sv"
`include "datastream_agent/datastream_transaction.sv"
`include "datastream_agent/datastream_itf.sv"
`include "datastream_agent/datastream_sequencer.sv"
`include "datastream_agent/datastream_driver.sv"
`include "datastream_agent/datastream_monitor.sv"
`include "datastream_agent/datastream_agent.sv"

`include "stats_agent/stats_itf.sv"
`include "stats_agent/stats_transaction.sv"
`include "stats_agent/stats_monitor.sv"
`include "stats_agent/stats_agent.sv"

`include "datastream_analyzer_scoreboard.sv"
`include "datastream_analyzer_env.sv"

`include "datastream_analyzer_assertions.sv"

module datastream_analyzer_tb#(int TESTCASE = 0, int DATASIZE = 8, int WINDOWSIZE = 4, int ERRNO = 0);

    import objections_pkg::*;

    datastream_itf#(DATASIZE) input_itf();
    stats_itf#(DATASIZE) output_itf();

    logic clk_i;
    logic frame_o;

    default clocking cb @(posedge clk_i);
    endclocking

    assign clk_i = input_itf.clk_i;
    assign frame_o = output_itf.frame_o;

    datastream_analyzer#(DATASIZE, WINDOWSIZE, ERRNO) duv(
        .clk_i(input_itf.clk_i),
        .rst_i(input_itf.rst_i),
        .data_i(input_itf.data_i),
        .valid_i(input_itf.valid_i),
        .ready_o(input_itf.ready_o),
        .data_o(output_itf.data_o),
        .valid_o(output_itf.valid_o),
        .frame_o(output_itf.frame_o)
    );


    // Binding of the DUV and the assertions module
    bind duv datastream_analyzer_assertions#(DATASIZE) binded(.*);

    // clock generation
    always #5 input_itf.clk_i = ~input_itf.clk_i;

    assign output_itf.clk_i = input_itf.clk_i;

    initial begin
        // Set the drain time for objections
        objections_pkg::objection::get_inst().set_drain_time(1000);

        // Wait for the TB to start
        ##10;
        while (!objections_pkg::objection::get_inst().should_finish()) begin
            ##1;
        end
        $display("End of simulation");
        $stop;
    end

    initial begin
        datastream_analyzer_env#(DATASIZE, WINDOWSIZE) env;

        // Building the entire environment
        env = new;
        env.input_itf = input_itf;
        env.output_itf = output_itf;
        env.testcase = TESTCASE;
        env.build();
        env.connect();
        env.run();

        $finish;
    end

endmodule
