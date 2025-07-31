
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_reg_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rs2,
    output logic [4:0] rd,
    output logic [4:0] alu_control
);

// Edit the code here begin ---------------------------------------------------

    // assign rs1 = 'b0;
    // assign rs2 = 'b0;
    // assign rd = 'b0;
    // assign alu_control = 'b0;
    logic [9:0] temp;
    always_comb begin
        temp[9:0] = {instruction_code[14:12],instruction_code[31:25]};

        rs1 = instruction_code[19:15];
        rs2 = instruction_code[24:20];
        rd =  instruction_code[11:7];
        case(temp)
        10'b0: alu_control=  `ADD;
        10'b0000100000: alu_control = 5'd2;
        10'b1000000000: alu_control = 5'd3;
        10'b1100000000: alu_control = 5'd4;
        10'b1110000000: alu_control = 5'd5;
        10'b0010000000: alu_control = 5'd6;
        10'b1010000000: alu_control = 5'd7;
        10'b1010100000: alu_control = 5'd8;
        10'b0100000000: alu_control = 5'd9;
        10'b0110000000: alu_control = 5'd10;
        default: alu_control =5'b0;
        endcase;

        
    end
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_reg_inst.vcd");
        $dumpvars(0, decode_reg_inst);
    end
`endif

endmodule
