
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_load_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [2:0] load_control
);

// Edit the code here begin ---------------------------------------------------

    assign rs1 = 'b0;
    assign rd = 'b0;
    assign imm = 'b0;
    assign load_control = 'b0;
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_load_inst.vcd");
        $dumpvars(0, decode_load_inst);
    end
`endif

endmodule
