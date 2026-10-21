module immgen (
    input logic [31:0] instr,
    output logic [31:0] immj,
    output logic [31:0] immb,
    output logic [31:0] immi,
    output logic [31:0] imms,
    output logic [31:0] immu
);
    if (instr[6:0] == 6'b0000011) begin
        immi = {20{instr[31]},instr[31:20]};
        imms = {20{instr[31]},instr[31:25],instr[11:7]};
        immu = {instr[31:12],12{1'b0}};
        immb = {20{instr[31]},instr[7],instr[30:25],instr[11:8],1'b0};
        immj = {12{instr[31]},instr[19:12],instr[20],instr[30:21],1'b0};
    end
endmodule