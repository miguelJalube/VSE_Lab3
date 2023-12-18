/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : stats_agent.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the output agent, getting information from the
              datastream analyzer.

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef STATS_AGENT_SV
`define STATS_AGENT_SV

class stats_agent#(int DATASIZE = 8, int WINDOWSIZE = 4);


    int testcase;

    stats_monitor#(DATASIZE, WINDOWSIZE) monitor;

    virtual stats_itf#(DATASIZE) vif;

    task build;

        monitor = new;

        monitor.testcase = testcase;

    endtask : build

    task connect;

        monitor.vif = vif;

    endtask : connect

    task run;

        fork
            monitor.run();
        join;

    endtask : run


endclass : stats_agent


`endif // STATS_AGENT_SV
