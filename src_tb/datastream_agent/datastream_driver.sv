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
Description : This file contains the driver representing the datastream sender
              behavior

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef DATASTREAM_DRIVER_SV
`define DATASTREAM_DRIVER_SV


class datastream_driver#(int DATASIZE = 8, int WINDOWSIZE = 4);


    int testcase;

    datastream_fifo_t sequencer_to_driver_fifo;

    virtual datastream_itf#(DATASIZE) vif;

    task drive_transaction(datastream_transaction packet);
        objections_pkg::objection::get_inst().raise();

        // TODO : Drive the transaction
        vif.valid_i <= 1;
        foreach (packet.data[i]) begin
            vif.data_i <= packet.data[i];
            @(posedge vif.clk_i);
        end
        vif.valid_i <= 0;
        @(posedge vif.clk_i);
        objections_pkg::objection::get_inst().drop();
 
    endtask

    task run;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        $display("Driver : start");

        vif.valid_i <= 0;
        vif.data_i <= 0;
        vif.rst_i <= 1;
        @(posedge vif.clk_i);
        vif.rst_i <= 0;
        @(posedge vif.clk_i);
        @(posedge vif.clk_i);

        while (1) begin
            sequencer_to_driver_fifo.get(trans);
            drive_transaction(trans);
            $display("I sent a transaction!!!!");
        end

        $display("Driver : end");
    endtask : run

endclass : datastream_driver



`endif // DATASTREAM_DRIVER_SV
