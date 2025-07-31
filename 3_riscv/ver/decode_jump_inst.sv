
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_jump_inst(
    input logic [31:0] instruction_code,
    output logic [4:0] rd,
    output logic [4:0] rs1,
    output logic [20:0] imm,
    output logic [1:0] jump_control
);

// Edit the code here begin ---------------------------------------------------

    // assign rd = 'b0;
    // assign rs1 = 'b0;
    // assign imm = 'b0;
    // assign jump_control = 'b0;
     // Opcode constants
   // Opcode constants

// Declare internal signals outside always_comb
assign rd = instruction_code[11:7];
logic [2:0] func3;

logic [6:0] opc;
assign opc = instruction_code[6:0];

always@(*) begin
    rs1 = 5'b0;
    imm = 21'b0;

    if(opc == 7'b1101111) begin
        imm = {instruction_code[31], instruction_code[19:12], instruction_code[20], instruction_code[30:21], 1'b0};
        jump_control = `JAL;
    end
    else if(opc == 7'b1100111) begin
        func3= instruction_code[14:12];
        if(func3 == 3'b000) begin
            imm = {9'b0, instruction_code[31:20]};
            rs1 = instruction_code[19:15];
            jump_control = `JALR;
        end
        else jump_control = `JMP_NOP;
    end
    else jump_control = `JMP_NOP;
end
       
    // Decode JALR (I-type)
    


// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_jump_inst.vcd");
        $dumpvars(0, decode_jump_inst);
    end
`endif

endmodule
