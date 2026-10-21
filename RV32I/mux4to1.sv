module mux4to1 (
    input logic [31:0] ALUin,
    input logic [31:0] IMMU,
    input logic [31:0] MEMin,
    input logic [31:0] pcnext,
    input logic [31:0] pc;
    input logic [2:0] wbmux,
    output logic [31:0] rd
);
    always_comb begin : mux4to1
        case(wbmux)
            3'b000: rd = ALUin;
            3'b001: rd = IMMU;
            3'b010: rd = MEMin;
            3'b011: rd = (IMMU + pc);
            3'b100: rd = pcnext;
        endcase
    end
endmodule