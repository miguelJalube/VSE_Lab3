/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : datastream_itf.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the interface from the datastream sender to
              the analyzer

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef DATASTREAM_ITF_SV
`define DATASTREAM_ITF_SV

interface datastream_itf#(int DATASIZE = 8);
    logic clk_i = 0;
    logic rst_i;
    logic[DATASIZE-1:0] data_i;
    logic valid_i;
    logic ready_o;
endinterface : datastream_itf

`endif // DATASTREAM_ITF_SV
