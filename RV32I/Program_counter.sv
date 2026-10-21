module Program_counter (
    input logic clk,
    input logic nrst,
    input logic [31:0] IMMB,
    input logic [31:0] IMMJ,
    input logic [31:0] JT,
    input logic [1:0] pcmux,
    output logic [31:0] pc_out
    output logic [31:0] nextpc_out
);
    reg [31:0] pc;

    always_comb begin : adder
        case(pcmux)
            2'b00: pc_next = pc + 4;
            2'b01: pc_next = JT & ~1;
            2'b10: pc_next = (IMMB + pc);
            2'b11: pc_next = (IMMJ + pc);
        endcase 
    end

    always_ff @(posedge clk)
    begin
        if (!nrst) 
            pc <= 31'd0;
        else
            pc <= pc_next;
    end
    assign pc_out = pc;
    assign nextpc_out = pc + 4;
endmodule