`timescale 1ns/100ps
module moving_average#(
    parameter DATA_WD = 16
)(
    input  logic                      i_clk,
    input  logic                      i_rstb,
    input  logic signed [DATA_WD-1:0] i_data,
    output logic signed [DATA_WD-1:0] o_data
);

// Edit the code here begin ---------------------------------------------------

    assign o_data = 'b0;

// Edit the code here end -----------------------------------------------------

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/moving_average.vcd");
        $dumpvars(0, moving_average);
    end
`endif
   
endmodule

     
