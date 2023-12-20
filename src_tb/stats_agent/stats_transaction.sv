/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : stats_packet.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the definition of the output statistics
              transactions that come out of the datastream analyzer

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/


`ifndef STATS_PACKET_SV
`define STATS_PACKET_SV

class stats_transaction#(int DATASIZE = 8, int WINDOWSIZE = 4);
    bit [DATASIZE-1:0] min;
    bit [DATASIZE-1:0] max;
    bit [DATASIZE-1:0] moy;

endclass : stats_transaction


typedef mailbox #(stats_transaction) stats_fifo_t;

`endif // STATS_PACKET_SV
