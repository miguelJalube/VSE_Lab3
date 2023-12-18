/*******************************************************************************
HEIG-VD
Haute Ecole d'Ingenerie et de Gestion du Canton de Vaud
School of Business and Engineering in Canton de Vaud
********************************************************************************
REDS
Institute Reconfigurable Embedded Digital Systems
********************************************************************************

File     : stats_itf.sv
Author   : Yann Thoma
Date     : 08.12.2023

Context  : Lab for the verification of a datastream analyzer

********************************************************************************
Description : This file contains the definition of the statistics interface for
              the datastream analyzer.

********************************************************************************
Dependencies : -

********************************************************************************
Modifications :
Ver   Date        Person     Comments
1.0   08.12.2023  YTA        Initial version

*******************************************************************************/

`ifndef STATS_ITF_SV
`define STATS_ITF_SV

interface stats_itf#(int DATASIZE = 8);
    logic clk_i;
    logic[DATASIZE-1:0] data_o;
    logic valid_o;
	logic frame_o;
endinterface : stats_itf

`endif // STATS_ITF_SV
