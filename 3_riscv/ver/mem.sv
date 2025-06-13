
module mem(
    input logic i_clk,
    input logic i_rst,
    input logic [9:0] in_mem_addr,
    input logic in_mem_re_web,
    input logic [31:0] in_mem_write_data,
    input logic [3:0] in_mem_byte_en,
    output logic [31:0] out_mem_data
);

logic [31:0] memory_reg [0:1023];
logic [31:0] write_data_muxed;

// Edit the code here begin ---------------------------------------------------

    assign out_mem_data = 'b0;
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/mem.vcd");
        $dumpvars(0, mem);
    end
`endif

endmodule
