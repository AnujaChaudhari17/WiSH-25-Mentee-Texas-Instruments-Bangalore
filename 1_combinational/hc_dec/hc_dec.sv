module hc_dec#(
    parameter DATA_WD = 4,
    parameter CHK_WD  = 3
)(
    input   logic   [DATA_WD+CHK_WD-1:0]  i_enc_data,
    output  logic                         o_err_flag,
    output  logic   [DATA_WD-1:0]         o_dec_data
);
    logic [CHK_WD-1:0]  chk_bits_cmp;
    logic [DATA_WD+CHK_WD-1:0] corr_packet;
    logic [CHK_WD-1:0]  err_pos;
    int k;

// Edit the code here begin ---------------------------------------------------

    always_comb begin
       o_dec_data = {(DATA_WD){1'b0}};
    end

    assign o_err_flag = 1'b0;

// Edit the code here end -----------------------------------------------------

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/hc_dec.vcd");
        $dumpvars(0, hc_dec);
    end
`endif

endmodule
