/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : ble_analyzer_scoreboard.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the scoreboard responsible for comparing the
              input/output transactions

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef DATASTREAM_ANALYZER_SCOREBOARD_SV
`define DATASTREAM_ANALYZER_SCOREBOARD_SV


class datastream_analyzer_scoreboard#(int DATASIZE = 8, int WINDOWSIZE = 4);
    int testcase;
    
    datastream_fifo_t datastream_to_scoreboard_fifo; // better name: datastream_monitor_to_scoreboard_fifo
    stats_fifo_t monitor_to_scoreboard_fifo; // better name: stats_monitor_to_scoreboard_fifo

    task run;
        bit [DATASIZE-1:0] min_val;
        
        bit [DATASIZE-1:0] max_val;
        bit [DATASIZE-1:0] mean_val;
        bit [DATASIZE-1:0] sum;
        int unsigned i;
    begin
        $display("[datastream_analyzer_scoreboard.sv] Scoreboard : Start");

        while (1) begin

            automatic datastream_transaction datastream_trans = new;
            automatic stats_transaction stats_trans = new;
            
            // Get data from the monitors. Here there is one transaction from each,
            // but it can obviously be changed if required
            datastream_to_scoreboard_fifo.get(datastream_trans);
            monitor_to_scoreboard_fifo.get(stats_trans);
            
            $display("START =============================================");
            foreach (datastream_trans.data[i]) begin
                $display("[datastream_analyzer_scoreboard.sv] data[%2d] : %b", i, datastream_trans.data[i]);
            end
            $display("END   =============================================");

            // display types
            $display("[datastream_analyzer_scoreboard.sv] min    : %b", stats_trans.min);
            
            // compute min
            min_val = datastream_trans.data[0];
            foreach (datastream_trans.data[i]) begin
                if (datastream_trans.data[i] < min_val) begin
                    min_val = datastream_trans.data[i];
                end
            end
            $display("[datastream_analyzer_scoreboard.sv] min_val : %b", min_val);

            // compute max
            max_val = datastream_trans.data[0];
            foreach (datastream_trans.data[i]) begin
                if (datastream_trans.data[i] > max_val) begin
                    max_val = datastream_trans.data[i];
                end
            end
            $display("[datastream_analyzer_scoreboard.sv] max_val : %b", max_val);

            // compute mean
            mean_val = datastream_trans.data[0];
            sum = 0;
            foreach (datastream_trans.data[i]) begin
                sum = sum + datastream_trans.data[i];
                if (i != 0) begin
                    mean_val = sum / i;
                end
            end
            $display("[datastream_analyzer_scoreboard.sv] mean_val: %b", mean_val);
            
            assert(stats_trans.min == min_val);
            assert(stats_trans.max == max_val);
            assert(stats_trans.moy == mean_val);
        end

        $display("[datastream_analyzer_scoreboard.sv] Scoreboard : End");
    
    end
    endtask : run

endclass : datastream_analyzer_scoreboard

`endif // DATASTREAM_ANALYZER_SCOREBOARD_SV
