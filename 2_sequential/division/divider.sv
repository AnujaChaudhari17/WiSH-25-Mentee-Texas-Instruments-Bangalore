module divider #(
    parameter   int     D_WIDTH     = 4
)(
    input   logic                   i_clk,
    input   logic                   i_rstn,
    input   logic   [D_WIDTH-1:0]   i_dividend,
    input   logic   [D_WIDTH-1:0]   i_divisor,
    input   logic                   i_start,
    output  logic                   o_done,
    output  logic   [D_WIDTH-1:0]   o_quotient,
    output  logic   [D_WIDTH-1:0]   o_remainder
);

// Edit the code here begin ---------------------------------------------------

   assign o_done      = 1'b1;
   assign o_quotient  = 'b0;
   assign o_remainder = 'b0;
   
// Edit the code here end -----------------------------------------------------

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/divider.vcd");
        $dumpvars(0, divider);
    end
`endif

endmodule
