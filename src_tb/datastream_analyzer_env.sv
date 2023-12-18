/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : datastream_analyzer_env.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the environment that instantiates the input
              and output agent, as well as the scoreboard

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef DATASTREAM_ANALYZER_ENV_SV
`define DATASTREAM_ANALYZER_ENV_SV

class datastream_analyzer_env#(int DATASIZE = 8, int WINDOWSIZE = 4);

    int testcase;

    datastream_agent#(DATASIZE, WINDOWSIZE) input_agent;
    stats_agent#(DATASIZE, WINDOWSIZE) output_agent;

    datastream_analyzer_scoreboard#(DATASIZE, WINDOWSIZE) scoreboard;

    virtual datastream_itf#(DATASIZE) input_itf;
    virtual stats_itf#(DATASIZE) output_itf;

    datastream_fifo_t datastream_to_scoreboard_fifo;
    stats_fifo_t monitor_to_scoreboard_fifo;

    task build;
        datastream_to_scoreboard_fifo = new(10);
        monitor_to_scoreboard_fifo   = new(100);

        input_agent = new;
        output_agent = new;
        scoreboard = new;

        input_agent.testcase = testcase;
        output_agent.testcase = testcase;
        scoreboard.testcase = testcase;

        input_agent.vif = input_itf;
        output_agent.vif = output_itf;

        input_agent.build();
        output_agent.build();
    
    endtask : build

    task connect;

        input_agent.datastream_to_scoreboard_fifo = datastream_to_scoreboard_fifo;
        scoreboard.datastream_to_scoreboard_fifo = datastream_to_scoreboard_fifo;

        output_agent.monitor.monitor_to_scoreboard_fifo = monitor_to_scoreboard_fifo;
        scoreboard.monitor_to_scoreboard_fifo = monitor_to_scoreboard_fifo;

        input_agent.connect();
        output_agent.connect();

    endtask : connect

    task run;

        fork
            input_agent.run();
            output_agent.run();
            scoreboard.run();
        join;

    endtask : run

endclass : datastream_analyzer_env


`endif // DATASTREAM_ANALYZER_ENV_SV
