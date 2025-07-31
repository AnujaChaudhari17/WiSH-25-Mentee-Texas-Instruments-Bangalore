
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_store_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [11:0] imm,
    output logic [2:0] store_control
);

// Edit the code here begin ---------------------------------------------------

    // assign rs1 = 'b0;
    // assign rs2 = 'b0;
    // assign imm = 'b0;
    // assign store_control = 'b0;
    logic [2:0] func3;

    always_comb begin
        rs1 = instruction_code[19:15];
        rs2 = instruction_code[24:20];
        imm = {instruction_code[31:25],instruction_code[11:7]};
        func3 =  instruction_code[14:12];
        case(func3)
        3'b000: store_control = `SB;
        3'b001: store_control = `SH;
        3'b010: store_control = `SW;
        default : store_control = 3'b0;
        endcase
    end
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_store_inst.vcd");
        $dumpvars(0, decode_store_inst);
    end
`endif

endmodule

