module prog_add_sub#(
    parameter DATA_WD=4
)(
    input   logic   [DATA_WD-1:0]   i_a,
    input   logic   [DATA_WD-1:0]   i_b,
    input   logic                   i_mode,
    output  logic                   o_ovr,
    output  logic   [DATA_WD:0]     o_arith_out
);

// Edit the code here begin ---------------------------------------------------
 logic [DATA_WD-1:0] b_mod;
    logic  c_in;
    always_comb begin
        if (i_mode == 0) begin
            b_mod = i_b;
            c_in  = 1'b0;
        end else begin
            b_mod = ~i_b;  
            c_in  = 1'b1;
        end
    end
    logic [DATA_WD:0] temp;
    ripple_carry_adder #(.DATA_WD(DATA_WD)) u_adder (
        .i_a(i_a),
        .i_b(b_mod),
        .i_c(c_in),
        .o_arith_out(temp)
        
    );
    always_comb begin
        if(i_mode==1)begin
            o_arith_out={1'b0,temp[3:0]};
        end
        else
        o_arith_out=temp;
    end

    // Overflow detection
    always_comb begin
        o_ovr = 1'b0;
        if (i_mode == 1 && (i_a < i_b)) begin
            o_ovr = 1'b1;
        end
        
    end

    
// Edit the code here end -----------------------------------------------------

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/prog_add_sub.vcd");
        $dumpvars(0, prog_add_sub);
    end
`endif

endmodule
