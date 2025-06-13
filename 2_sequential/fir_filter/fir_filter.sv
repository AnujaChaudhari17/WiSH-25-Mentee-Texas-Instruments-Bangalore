`timescale 1ns/100ps
module fir_filter(
    input  logic               i_clk,
    input  logic               i_rstb,
    input  logic signed [15:0] i_data,
    input  logic signed [15:0] i_coeff0,
    input  logic signed [15:0] i_coeff1,
    input  logic signed [15:0] i_coeff2,
    input  logic signed [15:0] i_coeff3,
    output logic signed [15:0] o_data
);

// Edit the code here begin ---------------------------------------------------

    assign o_data = 'b0;

// Edit the code here end -----------------------------------------------------

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/fir_filter.vcd");
        $dumpvars(0, fir_filter);
    end
`endif

endmodule
