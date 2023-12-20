/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : datastream_driver.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the monitor observing the datastream interface

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef DATASTREAM_MONITOR_SV
`define DATASTREAM_MONITOR_SV

import objections_pkg::*;

class datastream_monitor#(int DATASIZE = 8, int WINDOWSIZE = 4);

    int testcase;

    datastream_fifo_t monitor_to_scoreboard_fifo;

    virtual datastream_itf#(DATASIZE) vif;

    task run;
        while (1) begin
            datastream_transaction#(DATASIZE, WINDOWSIZE) trans = new;
            // TODO : Implement the monitor's behavior
            
            foreach (trans.data[i]) begin
                trans.data[i] = vif.data_i;
            end
            @(posedge vif.clk_i);

            // At some stage send the packet to the scoreboard
            monitor_to_scoreboard_fifo.put(trans);
        end
    endtask


endclass : datastream_monitor



`endif // DATASTREAM_MONITOR_SV
