`ifndef FILE_INCL
    `include "processor_defines.sv"
`endif

module store(
    input logic i_clk,
    input logic i_rst,
    input logic [31:0] rs1_val,
    input logic [31:0] rs2_val,
    input logic [31:0] imm,
    input logic [2:0] store_control,
    output logic stall_pc,
    output logic ignore_curr_inst,
    output logic mem_rw_mode,
    output logic [31:0] mem_addr,
    output logic [31:0] mem_write_data,
    output logic [3:0] mem_byte_en
);

// Edit the code here begin ---------------------------------------------------

    // assign stall_pc = 'b0;
    // assign ignore_curr_inst = 'b0;
    // assign mem_rw_mode = 'b0;
    // assign mem_addr = 'b0;
    // assign mem_write_data = 'b0;
    // assign mem_byte_en = 'b0;

    logic [2:0] store_control_temp;
    logic [31:0] mem_addr_temp;

    always @(posedge i_clk or negedge i_rst) begin
        if (!i_rst) begin
            ignore_curr_inst <= 0;
            // store_control_temp <= 'h0;
            // mem_addr_temp <= 'h0;

        end else begin
            case (store_control)
                `SB, `SH, `SW: begin
                    ignore_curr_inst <= 1;
                    // store_control_temp <= store_control;
                    // mem_addr_temp <= mem_addr;
                end
                default: begin
                    ignore_curr_inst <= 0;
                    // store_control_temp <= 'h0;
                    // mem_addr_temp <= 'h0;
                end
            endcase
        end
    end
    
     always_comb begin
        case(store_control)
        `SW, `SB, `SH: begin
            mem_rw_mode = 'h0;
            mem_addr = rs1_val + imm;
            stall_pc = 1;
        end
        `STR_NOP: begin
            mem_rw_mode = 'h1;
            mem_addr = 'h0;
            stall_pc = 0;
        end
        default: begin
            mem_rw_mode = 'h1;
            mem_addr = 'h0;
            stall_pc = 0;
        end
        endcase
    end

    always_comb begin
        case(store_control)
         `STR_NOP: begin
            mem_write_data = 'h0;
            mem_byte_en = 'h0;
         end
         `SB:
            begin
                case(mem_addr[1:0])
                2'b00: begin
                    mem_write_data[7:0]= rs2_val[7:0];
                    mem_write_data[31:8] = 'h0;
                    mem_byte_en = 'b0001;
                end
                2'b01: begin
                    mem_write_data[15:8]= rs2_val[7:0];
                    {mem_write_data[31:16], mem_write_data[7:0]} = 'h0;
                    mem_byte_en = 'b0010;
                end
                2'b10: begin
                    mem_write_data[23:16]= rs2_val[7:0];
                    {mem_write_data[31:24], mem_write_data[15:0]} = 'h0;
                    mem_byte_en = 'b0100;
                end
                2'b11: begin
                    mem_write_data[31:24]= rs2_val[7:0];
                    mem_write_data[23:0] = 'h0;
                    mem_byte_en = 'b1000;
                end
                endcase
            end
         `SH: begin
            case(mem_addr[1])
                2'b0: begin
                    mem_write_data[15:0]= rs2_val[15:0];
                    mem_write_data[31:16] = 'h0;
                    mem_byte_en = 'b0011;
                end
                2'b1: begin
                    mem_write_data[31:16]= rs2_val[15:0];
                    mem_write_data[15:0] = 'h0;
                    mem_byte_en = 'b1100;
                end
            endcase
         end
         `SW: begin
            mem_write_data = rs2_val;
            mem_byte_en = 'b1111;
         end
         default: begin
            mem_write_data = 'h0;
            mem_byte_en = 'b0000;
         end
        endcase
    end

   
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/store.vcd");
        $dumpvars(0, store);
    end
`endif

endmodule
