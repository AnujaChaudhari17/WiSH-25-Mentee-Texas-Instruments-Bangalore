
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module branch(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] pc,
    input logic [31:0] imm,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [2:0] branch_control,
    output logic pc_update_control,
    output logic [31:0] pc_update_val,
    output logic ignore_curr_inst
);

// Edit the code here begin ---------------------------------------------------

    // assign pc_update_control = 'b0;
    // assign pc_update_val = 'b0;
    // assign ignore_curr_inst = 'b0;
    always@(posedge i_clk or negedge i_rst) begin
        if(~i_rst) begin
            ignore_curr_inst <= 1'b0;
        end
        else 
    ignore_curr_inst <= pc_update_control;
    end

    always_comb begin
        if(branch_control == `BEQ && rs1_val == rs2_val) begin
            pc_update_control = 1'b1;
            pc_update_val = pc + imm;
        end
        
        else if( branch_control == `BNE && rs1_val != rs2_val ) begin
            pc_update_control = 1'b1;
            pc_update_val = pc + imm;

        end
        else if(branch_control == `BLT && $signed(rs1_val) < $signed(rs2_val)) begin
            pc_update_control = 1'b1;
            pc_update_val = pc + imm;
        end
        else if(branch_control == `BGE && $signed(rs1_val) >= $signed(rs2_val)) begin
            pc_update_control = 1'b1;
            pc_update_val = pc + imm;
        end
        else if(branch_control == `BLTU && rs1_val < rs2_val) begin
            pc_update_control = 1'b1;
            pc_update_val = pc + imm;
        end
        else if(branch_control == `BGEU && rs1_val >= rs2_val) begin
            pc_update_control = 1'b1;
            pc_update_val = pc + imm;
    end
    else if(branch_control == `BR_NOP ) begin
        pc_update_control = 1'b0;
         pc_update_val = 32'b0;
    end

    else begin
    pc_update_control = 1'b0;
    pc_update_val = 32'b0;
    end
    end
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/branch.vcd");
        $dumpvars(0, branch);
    end
`endif

endmodule
