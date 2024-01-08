/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : stats_monitor.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the monitor responsible for observing the
              output of the datastream analyzer and building the output
              transactions.

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version
1.1   27.12.2023  MJE, LSM   Add min, max and moy computation

*******************************************************************************/

`ifndef STATS_MONITOR_SV
`define STATS_MONITOR_SV


class stats_monitor#(int DATASIZE = 8, int WINDOWSIZE = 4);

    int testcase;

    virtual stats_itf#(DATASIZE) vif;

    stats_fifo_t monitor_to_scoreboard_fifo;

    task run;
        `DEBUG_DISPLAY($sformatf("[stats_monitor.sv] Monitor : start"));

        while (1) begin

            stats_transaction#(DATASIZE, WINDOWSIZE) stats_trans = new;
            
            @(posedge vif.clk_i);

            // Lis la valeur min
            @(negedge vif.clk_i);
            wait(vif.valid_o == 1);
            wait(vif.frame_o == 1);
            stats_trans.min = vif.data_o;
            @(posedge vif.clk_i);

            // Lis la valeur max
            @(negedge vif.clk_i);
            wait(vif.valid_o == 1);
            wait(vif.frame_o == 1);
            stats_trans.max = vif.data_o;
            @(posedge vif.clk_i);

            // Lis la valeur moyenne
            @(negedge vif.clk_i);
            wait(vif.valid_o == 1);
            wait(vif.frame_o == 1);
            stats_trans.moy = vif.data_o;
            @(posedge vif.clk_i);

            // At some stage, put a transaction in the FIFO
            monitor_to_scoreboard_fifo.put(stats_trans);

        end
        `DEBUG_DISPLAY($sformatf("[stats_monitor.sv] Monitor : end"));
    endtask : run

endclass : stats_monitor

`endif // STATS_MONITOR_SV
