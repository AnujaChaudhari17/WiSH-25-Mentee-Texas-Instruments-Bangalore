
module regfile(
    input logic i_clk,
    input logic i_rst,
    input logic [4:0] rs1,
    input logic [4:0] rs2,
    input logic [4:0] rd,
    input logic rd_write_control,
    input logic [31:0] rd_write_val,
    output logic [31:0] rs1_val,
    output logic [31:0] rs2_val
);

logic [31:0] regs [0:31];


// Edit the code here begin ---------------------------------------------------

    //assign rs1_val = 'b0;
    //assign rs2_val = 'b0;
    always @ (posedge i_clk or negedge i_rst)begin
        if(i_rst==0) begin
           for(int i=0;i<32;i=i+1) begin
                regs[i] <= 32'b0;
            end
        end
        else if(rd_write_control && rd!=5'd0) begin
           
            regs[rd] <= rd_write_val;
             $display("WRITE: rd = %0d, val = %0d, en = %b", rd, rd_write_val, rd_write_control);

        end
        end
    always_comb begin
    
        rs1_val=regs[rs1];
        rs2_val=regs[rs2];
        end
        
    
    
    
// Edit the code here end -----------------------------------------------------


/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/regfile.vcd");
        $dumpvars(0, regfile);
    end
`endif

endmodule
