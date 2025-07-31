module ripple_carry_adder#(
    parameter   DATA_WD=4
)(
    input   logic   [DATA_WD-1:0]   i_a,
    input   logic   [DATA_WD-1:0]   i_b,
    input   logic                   i_c,
    output  logic   [DATA_WD:0]     o_arith_out
);
// Edit the code here begin ---------------------------------------------------

    
    // assign o_arith_out[4]=c4;
    logic [DATA_WD:0]c;
    assign c[0]=i_c;
    genvar i;
    for( i=0;i<DATA_WD;i=i+1)
        fa u1(.a(i_a[i]),.b(i_b[i]),.cin(c[i]),.sum(o_arith_out[i]),.carry(c[i+1]));
    
    assign o_arith_out[4]=c[4];
// Edit the code here end -----------------------------------------------------

endmodule
module fa(
    input logic a,
    input logic b,
    input logic cin,
    output sum,
    output carry
);
assign sum=a^b^cin;
assign carry=((a&b))|((a^b)&cin);



endmodule
