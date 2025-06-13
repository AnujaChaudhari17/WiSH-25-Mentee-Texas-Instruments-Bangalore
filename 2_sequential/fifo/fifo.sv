`timescale 1ns/100ps
module fifo#(
    parameter D_WD = 16,
    parameter SIZE = 16
)(
    input  logic            i_clk,
    input  logic            i_rstb,
    input  logic [D_WD-1:0] i_data,
    input  logic            i_write,
    input  logic            i_read,
    output logic [D_WD-1:0] o_data,
    output logic            o_full
);

// Edit the code here begin ---------------------------------------------------

   assign o_full = 1'b0;
   assign o_data = 'b0;

// Edit the code here end -----------------------------------------------------

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/fifo.vcd");
        $dumpvars(0, fifo);
    end
`endif
   
endmodule
