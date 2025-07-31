
`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module load(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] imm,
    input logic [31:0] mem_data,
    input logic [4:0] rd_in,
    input logic [2:0] load_control,
    output logic stall_pc,
    output logic ignore_curr_inst,
    output logic rd_write_control,
    output logic [4:0] rd_out,
    output logic [31:0] rd_write_val,
    output logic mem_rw_mode,
    output logic [31:0] mem_addr
);

// Edit the code here begin ---------------------------------------------------
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/
assign mem_rw_mode= 1;
logic[31:0] comb_rd_val;
logic[2:0] load_control_d;
logic[31:0] mem_addr_seq;
always @ (posedge i_clk or negedge i_rst)
begin
    if (~i_rst)
    begin
        //ignore_curr_inst<=0;
        rd_write_control<=0;
        rd_out<=0;
        load_control_d<=0;
        mem_addr<=0;
        mem_addr_seq<=0;
    end
    else
    begin
        load_control_d<=load_control;
        if (load_control== `LD_NOP) 
        begin
            //ignore_curr_inst<=0;
            rd_write_control<=0;
            mem_addr_seq<=0;
            rd_out<=0;

        end
        else 
        begin
            //ignore_curr_inst<=1;
            rd_write_control<=1;
            mem_addr_seq<=mem_addr;
            rd_out<=rd_in;
        end
    end
end
    always @ (*)
    begin
        stall_pc=0;
        mem_addr=0;
        if (load_control)
        begin
            stall_pc=1;
            mem_addr= rs1_val + imm;
        end
        else 
        begin
            stall_pc=0;
            mem_addr=0;
        end
    end
always @ (*)
begin
    case(load_control_d)
    `LD_NOP: begin rd_write_val=0; ignore_curr_inst=1'b0; end
    `LB:
    begin
           ignore_curr_inst=1'b1;
        case(mem_addr_seq[1:0])
        2'b00: rd_write_val[7:0]= mem_data[7:0];
        2'b01: rd_write_val[7:0]= mem_data[15:8];
        2'b10: rd_write_val[7:0]= mem_data[23:16];
        2'b11: rd_write_val[7:0]= mem_data[31:24];
        endcase
        rd_write_val[31:8]= {24{rd_write_val[7]}};
    end
    `LH:
    begin
        ignore_curr_inst=1'b1;
        case(mem_addr_seq[1])
        2'b0: rd_write_val[15:0]= mem_data[15:0];
        2'b1: rd_write_val[15:0]= mem_data[31:16];
        endcase
        rd_write_val[31:16]= {16{rd_write_val[15]}};
    end
    `LW:
    begin
        ignore_curr_inst=1'b1;
        rd_write_val=mem_data;
    end
    `LBU:
    begin
        ignore_curr_inst=1'b1;
        case(mem_addr_seq[1:0])
        2'b00: rd_write_val[7:0]= mem_data[7:0];
        2'b01: rd_write_val[7:0]= mem_data[15:8];
        2'b10: rd_write_val[7:0]= mem_data[23:16];
        2'b11: rd_write_val[7:0]= mem_data[31:24];
        endcase
        rd_write_val[31:8]= {24{1'b0}};
    end
    `LHU:
    begin
        ignore_curr_inst=1'b1;
        case(mem_addr_seq[1])
        2'b0: rd_write_val[15:0]= mem_data[15:0];
        2'b1: rd_write_val[15:0]= mem_data[31:16];
        endcase
        rd_write_val[31:16]= {16{1'b0}};
    end

    endcase
end

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/load.vcd");
        $dumpvars(0, load);
    end
`endif

endmodule
