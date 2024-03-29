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

    task testcase_random;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        void'(trans.randomize());

        foreach (trans.data[i]) begin
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

     task testcase_ascending;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        foreach (trans.data[i]) begin
            trans.data[i] <= i;
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

    task testcase_full_0;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        foreach (trans.data[i]) begin
            trans.data[i] <= '{ (DATASIZE){0} };
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

    task testcase_full_1;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        foreach (trans.data[i]) begin
            trans.data[i] = '{ (DATASIZE){1} };
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

    task testcase_edge_1_rest_0;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        foreach (trans.data[i]) begin
            trans.data[i] <= '{ (DATASIZE){0} };
            trans.data[i][0] <= 1;
            trans.data[i][DATASIZE-1] <= 1;
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

    task testcase_edge_0_rest_1;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        foreach (trans.data[i]) begin
            trans.data[i] <= '{ (DATASIZE){1} };
            trans.data[i][0] <= 0;
            trans.data[i][DATASIZE-1] <= 0;
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

    task testcase_half_0_1;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        foreach (trans.data[i]) begin
            trans.data[i][DATASIZE/2-1:0] <= '{ (DATASIZE/2){0} };
            trans.data[i][DATASIZE-1:DATASIZE/2] <= '{ (DATASIZE/2){1} };
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

    task testcase_half_1_0;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        foreach (trans.data[i]) begin
            trans.data[i][DATASIZE/2-1:0] <= '{ (DATASIZE/2){1} };
            trans.data[i][DATASIZE-1:DATASIZE/2] <= '{ (DATASIZE/2){0} };
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

    task testcase_alternate_1_0;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        foreach (trans.data[i]) begin
            trans.data[i] <= '{ {DATASIZE{1'b1, 1'b0}} };
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

    task testcase_alternate_0_1;
        automatic datastream_transaction#(DATASIZE, WINDOWSIZE) trans;
        trans = new;
        foreach (trans.data[i]) begin
            trans.data[i] <= '{ {DATASIZE{1'b0, 1'b1}} };
            `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] trans.data[%2d] : %b", i, trans.data[i]));
        end
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] sequencer -> driver"));
        sequencer_to_driver_fifo.put(trans);
    endtask

    task run;
        
        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] Sequencer : start"));

        case (testcase)
            0: begin // Run all
                testcase_random;
                testcase_ascending;
                testcase_full_0;
                testcase_full_1;
                testcase_edge_1_rest_0;
                testcase_edge_0_rest_1;
                testcase_half_0_1;
                testcase_half_1_0;
                testcase_alternate_1_0;
                testcase_alternate_0_1;
            end
            1: begin testcase_random; end
            2: begin testcase_ascending; end
            3: begin testcase_full_0; end
            4: begin testcase_full_1; end
            5: begin testcase_edge_1_rest_0; end
            6: begin testcase_edge_0_rest_1; end
            7: begin testcase_half_0_1; end
            8: begin testcase_half_1_0; end
            9: begin testcase_alternate_1_0; end
            10: begin testcase_alternate_0_1; end
        endcase

        `DEBUG_DISPLAY($sformatf("[datastream_sequencer.sv] Sequencer : end"));
    endtask : run

endclass : datastream_sequencer


`endif // DATASTREAM_SEQUENCER_SV
