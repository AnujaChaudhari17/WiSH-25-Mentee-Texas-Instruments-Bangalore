module hc_enc#(
    parameter DATA_WD=4,
    parameter CHK_WD=3
)(
    input   logic   [DATA_WD-1:0]   i_data,
    output  logic   [DATA_WD+CHK_WD-1:0] o_enc_data
);
    logic   [CHK_WD-1:0]    chk_bits;
    logic   [DATA_WD+CHK_WD-1:0]    map_data;
    int j,k;

// Edit the code here begin ---------------------------------------------------

    always_comb begin
        o_enc_data  =   {(DATA_WD+CHK_WD){1'b0}};
    end

// Edit the code here end -----------------------------------------------------

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/hc_enc.vcd");
        $dumpvars(0, hc_enc);
    end
`endif
   
endmodule
