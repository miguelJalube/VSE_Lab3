/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : datastream_transaction.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the definition of the datastream in terms of
              a transaction.

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef DATASTREAM_TRANSACTION_SV
`define DATASTREAM_TRANSACTION_SV


class datastream_transaction#(int DATASIZE = 8, int WINDOWSIZE = 4);

    rand bit[DATASIZE-1:0] data[WINDOWSIZE-1:0];

endclass : datastream_transaction


typedef mailbox #(datastream_transaction) datastream_fifo_t;

`endif // DATASTREAM_TRANSACTION_SV
