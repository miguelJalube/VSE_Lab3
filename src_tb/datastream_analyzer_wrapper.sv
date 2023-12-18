/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS Institute
Reconfigurable Embedded Digital Systems
********************************************************************************

File     : datastream_sv_wrapper.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This module is a wrapper that binds the DUV with the
              module containing the assertions

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/


module datastream_analyzer_wrapper#(int DATASIZE = 8, int WINDOWSIZE = 4, int ERRNO = 0)(
    input logic clk_i,
    input logic rst_i,
    input logic[DATASIZE-1:0] data_i,
    input logic valid_i,
    input logic ready_o,
    input logic[DATASIZE-1:0] data_o,
    input logic valid_o,
    input logic frame_o
);

    // Instantiation of the DUV
    datastream_analyzer#(DATASIZE, WINDOWSIZE, ERRNO) duv(.*);

    // Binding of the DUV and the assertions module
    bind duv datastream_analyzer_assertions#(DATASIZE, WINDOWSIZE) binded(.*);

endmodule