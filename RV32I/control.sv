module control (
    input logic [31:0] instr,
    input logic BT,
    output logic [4:0] ALUop,
    output logic memwr,
    output logic [1:0] IRMUX,
    output logic WERF,
    output logic [1:0] PCMUX,
    output logic [2:0] wbmux,
    output logic ec,
    output logic eb
);
    logic [6:0] opcode = instr[6:0];
    logic [3:0] ALUR = {instr[30],instr[14:12]}
    logic [2:0] funct3 = instr[14:12];
    always_comb begin : control
        case(opcode)
            7'b0110011: begin //R-type
                IRMUX = 2'b00; //reg-reg
                PCMUX = 0;
                memwr = 0;
                WERF = 1; //write to reg
                case(funct3)
                    4'b000: ALUop = instr[30] ? 4'b0001 : 4'b0000; //sub/add
                    4'b001: ALUop = 4'b0010; //sll
                    4'b010: ALUop = 4'b0011; //slt
                    4'b011: ALUop = 4'b0100; //sltu
                    4'b100: ALUop = 4'b0101; //xor
                    4'b101: ALUop = instr[30] ? 4'b0111 : 4'b0110 ; //sra/srl
                    4'b110: ALUop = 4'b1000; //or
                    4'b111: ALUop = 4'b1001; //and
                endcase
            end
            7'b0010011: begin //I-type arith/log
                IRMUX = 2'b01;// IMMI
                PCMUX = 0;
                memwr = 0;
                WERF = 1; //write to reg
                case(funct3)
                    4'b000: ALUop = instr[30] ? 4'b0001 : 4'b0000; //subi/addi
                    4'b001: ALUop = 4'b0010; //slli
                    4'b010: ALUop = 4'b0011; //slti
                    4'b011: ALUop = 4'b0100; //sltui
                    4'b100: ALUop = 4'b0101; //xori
                    4'b101: ALUop = instr[30] ? 4'b0111 : 4'b0110 ; //srai/srli
                    4'b110: ALUop = 4'b1000; //ori
                    4'b111: ALUop = 4'b1001; //andi
                endcase
            end
            7'b1100111: begin //I-type JALR
                PCMUX = 2'b01; // JT
                IRMUX = 2'b01; // IMMI
                ALUop = 4'b0000; //addi
                wbmux = 3'b100; //PC+4
                memwr = 0;
                WERF = 1; //write to reg
            end
            7'b0000011: begin //load
                IRMUX = 2'b01; // IMMI
                PCMUX = 2'b00; //pc + 4
                WERF = 1; //write to reg
                ALUop = 4'b0000; //addi
                wbmux = 3'b010; //memory
            end
            7'b1101111: begin //JAL
                PCMUX = 2'b11; // IMMJ
                wbmux = 3'b100; //PC+4
                memwr = 0;
                WERF = 0; //write to reg
                IRMUX = 2'b11 // nothing
            end
            7'b0100011: begin //S-type
                IRMUX = 2'b01; // IMMI
                ALUop = 4'b0000;
                PCMUX = 2'b00; //pc + 4
                memwr = 1; //write to memory
                WERF = 0; //write to reg
            end
            7'b1100011: begin //B-type
                IRMUX = 2'b00; //reg-reg
                memwr = 0;
                WERF = 0; //write to reg
                case (funct3)
                    4'b000: ALUop = 4'b1010; //Beq
                    4'b001: ALUop = 4'b1011; //Bne
                    4'b100: ALUop = 4'b1100; //Blt
                    4'b101: ALUop = 4'b1101; //Bge
                    4'b110: ALUop = 4'b1110; //BltU
                    4'b111: ALUop = 4'b1111; //BgeU
                endcase
                PCMUX = BT ? 2'b10 : 2'b00; //immB/pc + 4
            end
            7'b0110111: begin // U-type LUI
                memwr = 0;
                WERF = 1; //write to reg
                wbmux = 3'b001; //IMMU
                pcmux = 2'b00; //pc + 4
            end
            7'b0010111: begin
                memwr = 0;
                WERF = 1; //write to reg
                wbmux = 3'b100; //IMMU + pc
                pcmux = 2'b00; //pc + 4
            end
        endcase
    end
endmodule