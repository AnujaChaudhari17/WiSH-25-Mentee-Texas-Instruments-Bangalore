
module mem(
    input logic i_clk,
    input logic i_rst,
    input logic [9:0] in_mem_addr,
    input logic in_mem_re_web,//read=1,write=0
    input logic [31:0] in_mem_write_data,
    input logic [3:0] in_mem_byte_en,
    output logic [31:0] out_mem_data
);

logic [31:0] memory_reg [0:1023];
logic [31:0] write_data_muxed;

// Edit the code here begin ---------------------------------------------------

    //assign out_mem_data = 'b0;
    integer i;
    always @(posedge i_clk or negedge i_rst) begin
        if(i_rst==0)begin
            out_mem_data<=32'b0;
    end  
    else begin
        if(in_mem_re_web==1)begin
            out_mem_data<=memory_reg[in_mem_addr];
        end
        else begin
            for(i=0;i<4;i=i+1)begin
                if(in_mem_byte_en[i]==1)begin
                 memory_reg[in_mem_addr][ 8*i+:8]<=in_mem_write_data[ 8*i+:8];

                end
            end
        end

    end
    end
    
    
// Edit the code here end -----------------------------------------------------

/*
	Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef SUBMODULE_DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/mem.vcd");
        $dumpvars(0, mem);
    end
`endif

endmodule
