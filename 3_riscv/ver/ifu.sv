
module ifu(
    input logic i_clk,
    input logic i_rst,
    input logic stall_pc,
    input logic pc_update_control,
    input logic [31:0] pc_update_val,
    output logic [31:0] pc,
    output logic [31:0] prev_pc
);

// Edit the code here begin ---------------------------------------------------

    //assign pc = 'b0;
    //assign prev_pc = 'b0;
    always@(posedge i_clk or negedge i_rst) begin
        if(i_rst == 0)begin
            pc <= 32'b0;
            prev_pc <= 32'b0;
        end
        else if(stall_pc == 0)begin
            if(pc_update_control)begin
                prev_pc <= pc;
                pc <= pc_update_val;
            end
            else begin
            
                prev_pc <= pc;
                pc <= pc + 4;
            
        end
        end
        else begin
            pc <= pc;
            prev_pc <= prev_pc;
        end
        
    end
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/ifu.vcd");
        $dumpvars(0, ifu);
    end
`endif

endmodule
