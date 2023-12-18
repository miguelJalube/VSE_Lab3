/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : datastream_sequencer.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the sequencer responsible for generating the
              datastream that has to be played.

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef DATASTREAM_SEQUENCER_SV
`define DATASTREAM_SEQUENCER_SV

class datastream_sequencer#(int DATASIZE = 8, int WINDOWSIZE = 4);

    int testcase;
    
    datastream_fifo_t sequencer_to_driver_fifo;

    task run;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        $display("Sequencer : start");

        // TODO : Implement a good sequencer behavior
        
        trans = new;
        void'(trans.randomize());

        sequencer_to_driver_fifo.put(trans);

        $display("Sequencer : I sent a transaction");

        $display("Sequencer : end");
    endtask : run

endclass : datastream_sequencer


`endif // DATASTREAM_SEQUENCER_SV
