/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS Institute
Reconfigurable Embedded Digital Systems
********************************************************************************

File     : datastream_analyzer_assertions.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This module is contains the assertions to validate part of the
              datastream analyzer

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/


module datastream_analyzer_assertions#(int DATASIZE = 8, int WINDOWSIZE = 4)(
    input logic clk_i,
    input logic rst_i,
    input logic[DATASIZE-1:0] data_i,
    input logic valid_i,
    input logic ready_o,
    input logic[DATASIZE-1:0] data_o,
    input logic valid_o,
    input logic frame_o
);

    // TODO : If you wish, write your assertions here

endmodule