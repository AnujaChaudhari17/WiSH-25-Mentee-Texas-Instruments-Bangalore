module sorting_box#(
    parameter DATA_WD = 8,
    parameter SIGNED=0
)(
    input   logic   [DATA_WD-1:0]   i_a[4],
    output  logic   [DATA_WD-1:0]   o_sorted_a[4]
);

// Edit the code here begin ---------------------------------------------------

    assign o_sorted_a[0] = 'b0;
    assign o_sorted_a[1] = 'b0;
    assign o_sorted_a[2] = 'b0;
    assign o_sorted_a[3] = 'b0;

// Edit the code here end -----------------------------------------------------   

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/sorting_box.vcd");
        $dumpvars(0, sorting_box);
    end
`endif
   

endmodule
