
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module decode_imm_inst(
    input logic [31:7] instruction_code,
    output logic [4:0] rs1,
    output logic [4:0] rd,
    output logic [11:0] imm,
    output logic [4:0] alu_control
);

// Edit the code here begin ---------------------------------------------------

    // assign rs1 = 'b0;
    // assign rd = 'b0;
    // assign imm = 'b0;
    // assign alu_control = 'b0;
    logic [2:0] func3;
     assign rs1 = instruction_code[19:15];
      assign  rd = instruction_code[11:7];
       assign imm = instruction_code [31:20];
    assign func3 = instruction_code[14:12];
    always@(*) begin
       
        
        case(func3)
        3'b000: alu_control = `ADDI;
        3'b100: alu_control = `XORI;
        3'b110 : alu_control = `ORI;
        3'b111:  alu_control = `ANDI;
        3'b001: begin
                if (imm[11:5] == 7'b0000000)
                    alu_control = `SLLI;
                else
                    alu_control = `ALU_NOP;
            end
            3'b101: begin
                if (imm[11:5] == 7'b0000000)
                    alu_control = `SRLI;
                else if (imm[11:5] == 7'h20)
                    alu_control = `SRAI;
                else
                    alu_control = `ALU_NOP;
            end
            3'b010: alu_control = `SLTI;
            3'b011: alu_control = `SLTIU;
            
            default: alu_control = `ALU_NOP;
        
        endcase
        
        
         
    end

    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/decode_imm_inst.vcd");
        $dumpvars(0, decode_imm_inst);
    end
`endif

endmodule
