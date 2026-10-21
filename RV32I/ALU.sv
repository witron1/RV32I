module ALU (
    input logic [3:0] ALUop,
    input logic [1:0] IRMUX,
    input logic [31:0] rs1,
    input logic [31:0] rs2,
    input logic [31:0] immi,
    input logic [31:0] imms,
    output logic [31:0] out,
    output logic [31:0] JT,
    output logic BT
);
    logic [31:0] add, sub, sll, slt, sltu, xor, srl, sra, or, and;


    always_comb begin : ALU
        case(IRMUX)
            2'b00: (a = rs1) && (b = rs2);
            2'b01: (a = rs1) && (b = immi)
            2'b10: (a = rs1) && (b = imms)
        endcase
        add = a + b;
        sub = $signed(a) - $signed(b);
        sll = a << b;
        slt = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
        sltu = (a < b) ? 32'd1 : 32'd0;
        xor = a ^ b;
        srl = a >> b;
        sra = $signed(a) >>> b;
        or = a | b;
        and = a & b;  


        case(ALUop)
            4'b0000: out = add;
            4'b0001: out = sub;
            4'b0010: out = sll;
            4'b0011: out = slt;
            4'b0100: out = sltu;
            4'b0101: out = xor;
            4'b0110: out = srl;
            4'b0111: out = sra;
            4'b1000: out = or;
            4'b1001: out = and;
            4'b1010: BT = (a == b) ? 1 : 0;
            4'b1011: BT = (a != b) ? 1 : 0;
            4'b1100: BT = ($signed(a) < $signed(b)) ? 1 : 0;
            4'b1101: BT = ($signed(a) >= $signed(b)) ? 1 : 0;
            4'b1110: BT = (a < b) ? 1 : 0;
            4'b1111: BT = (a => b) ? 1 : 0;
            default: 0;
        endcase
    end

endmodule