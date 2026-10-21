module decoder (
    input logic [31:0] instr,
    output logic [4:0] rd,
    output logic [4:0] rs1,
    output logic [4:0] rs2
);
    always_comb begin : decoder
        rs1 =  instr[19:15];
        rs2 = instr[24:20];
        rd = instr[11:7];
    end
endmodule