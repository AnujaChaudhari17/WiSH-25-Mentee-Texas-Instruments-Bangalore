//this is a sequence detector for 1111

module seq_detect (
    input   logic           i_clk,
    input   logic           i_rstn,
    input   logic           i_data,
    output  logic           o_detect
);

// Edit the code here begin ---------------------------------------------------

    assign o_detect = 'b0;

// Edit the code here end -----------------------------------------------------

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/seq_detect.vcd");
        $dumpvars(0, seq_detect);
    end
`endif

endmodule
