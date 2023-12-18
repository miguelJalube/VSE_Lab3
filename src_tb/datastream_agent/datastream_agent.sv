/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : datastream_agent.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the input agent, that is the one generating
              the data stream

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef DATASTREAM_AGENT_SV
`define DATASTREAM_AGENT_SV

class datastream_agent#(int DATASIZE = 8, int WINDOWSIZE = 4);


    int testcase;

    datastream_sequencer#(DATASIZE, WINDOWSIZE) sequencer;
    datastream_driver#(DATASIZE, WINDOWSIZE) driver;
    datastream_monitor#(DATASIZE, WINDOWSIZE) monitor;

    virtual datastream_itf#(DATASIZE) vif;

    datastream_fifo_t sequencer_to_driver_fifo;
    datastream_fifo_t datastream_to_scoreboard_fifo;

    task build;
        sequencer_to_driver_fifo     = new(1);

        sequencer = new;
        driver = new;
        monitor = new;

        sequencer.testcase = testcase;
        driver.testcase = testcase;
        monitor.testcase = testcase;

    endtask : build

    task connect;

        sequencer.sequencer_to_driver_fifo = sequencer_to_driver_fifo;
        driver.sequencer_to_driver_fifo = sequencer_to_driver_fifo;
        // driver.driver_to_scoreboard_fifo = datastream_to_scoreboard_fifo;
        monitor.monitor_to_scoreboard_fifo = datastream_to_scoreboard_fifo;

        driver.vif = vif;
        monitor.vif = vif;

    endtask : connect


    task run;

        fork
            sequencer.run();
            driver.run();
            monitor.run();
        join;

    endtask : run


endclass : datastream_agent


`endif // DATASTREAM_AGENT_SV