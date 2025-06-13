module nrzi_decode (
    input   logic           i_clk,
    input   logic           i_rstn,

    input   logic           i_nrzi,
    input   logic           i_valid,

    output  logic           o_data,
    output  logic           o_valid,
    output  logic           o_error
);

// Edit the code here begin ---------------------------------------------------

   assign o_data  = 1'b0;
   assign o_valid = 1'b0;
   assign o_error = 1'b0;

// Edit the code here end -----------------------------------------------------
   
/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/nrzi_decode.vcd");
        $dumpvars(0, nrzi_decode);
    end
`endif

endmodule
