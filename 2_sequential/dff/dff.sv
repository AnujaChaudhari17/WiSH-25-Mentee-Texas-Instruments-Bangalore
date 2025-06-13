module dff (
    input   logic       i_clk,
    input   logic       i_rstn,
    input   logic       i_d,
    output  logic       o_q
);

    always @(posedge i_clk or negedge i_rstn) begin
        if (~i_rstn) begin
            o_q         <= 1'b0;
        end else begin
            o_q         <= i_d;
        end
    end

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/dff.vcd");
        $dumpvars(0, dff);
    end
`endif

endmodule
