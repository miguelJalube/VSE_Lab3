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

    datastream_fifo_t datastream_to_scoreboard_fifo;

    virtual datastream_itf#(DATASIZE) vif;

    task run;
        while (1) begin
            datastream_transaction#(DATASIZE, WINDOWSIZE) trans = new;
            wait(vif.valid_i == 1);
            
            foreach (trans.data[i]) begin
                @(negedge vif.clk_i);
                trans.data[i] = vif.data_i;
                $display("[datastream_monitor.sv] data[%2d]:%b", i, trans.data[i]);
                $display("[datastream_monitor.sv] TIME:%0t", $time);
                // while (vif.ready_o == 0) begin @(posedge vif.clk_i); end
            end

            $display("[datastream_monitor.sv] Sent packet to scoreboard");
            $display("[datastream_monitor.sv] TIME:%0t", $time);

            // At some stage send the packet to the scoreboard
            datastream_to_scoreboard_fifo.put(trans);
            wait(vif.valid_i == 0);
        end
    endtask


endclass : datastream_monitor



`endif // DATASTREAM_MONITOR_SV
