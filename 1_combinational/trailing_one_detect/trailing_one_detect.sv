`timescale 1ns/100ps
module trailing_one_detect#(
    parameter DATA_WD = 8,
    parameter IND_WD  = $clog2(DATA_WD)
)(
    input  logic [DATA_WD-1:0] i_a,
    output logic [IND_WD-1:0]  o_index
);

// Edit the code here begin ---------------------------------------------------

   	assign o_index = 'b0;

// Edit the code here end -----------------------------------------------------
   
/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/trailing_one_detect.vcd");
        $dumpvars(0, trailing_one_detect);
    end
`endif
   
endmodule
