//this is a sequence detector for 1111

module seq_detect (
    input   logic           i_clk,
    input   logic           i_rstn,
    input   logic           i_data,//i_data,
    output  logic           o_detect//o_detect
);

// Edit the code here begin ---------------------------------------------------


   logic [2:0]y;
   logic [2:0]Y;
   localparam  A=3'b000;
   localparam  B=3'b001;
   localparam  C=3'b010;
   localparam  D=3'b011;
   localparam  E=3'b100;
   always@(*)begin
    case(y)
    A: begin if(i_data==1'b0)
        Y=A;
        else
        Y=B;
    end
    B: begin if(i_data==1'b0)
        Y=A;
        else
        Y=C;
    end
    C: begin if(i_data==1'b0)
        Y=A;
        else
        Y=D;
    end
    D:begin if(i_data==1'b0)
        Y=A;
        else
        Y=E;
    end
    E: begin if(i_data==1'b0)
        Y=A;
        else
        Y=E;
    end
    default:Y=3'b000;
    endcase
   end
   always @(posedge i_clk or negedge i_rstn)begin
    if(i_rstn==1'b0)begin
        y<=A;
    end
    else
    y<=Y;
   end
   assign o_detect=(y==E);

// Edit the code here end -----------------------------------------------------

/*
    Following section is necessary for dumping waveforms. This is needed for debug and simulations
*/

`ifndef DISABLE_WAVES
    initial begin
        $dumpfile("./sim_build/seq_detect.vcd");
        $dumpvars(0, seq_detect);
    end
`endif

endmodule

  
