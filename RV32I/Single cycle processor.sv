module CPU (
    input clk,
    input rst
);
    logic werf, bt, mwr, ec, eb;
    logic [31:0] immb, immj, imms, immi, immu, jt, pc, pcnext, ALUout, regrd1, regrd2, regwd, memwd, memrd, instr;
    logic [1:0] irmux, pcmux,
    logic [2:0] wbmux,
    logic [3:0] ALUop
    logic [4:0] regra1, regra2, regwa
    mod1 Program_counter(clk, rst, immb, immj, jt, pcmux, pc, pcnext);
    mod2 instruction_memory(pc, instr);
    mod3 decoder(instr, regwa, regra1, regra2);
    mod4 immgen(instr, immj, immb, immi, imms, immmu);
    mod5 control(instr, bt, ALUop, mwr, irmux, werf, pcmux, wbmux, ec, eb);
    mod6 register_file(rst, clk, werf, regra1, regra2, regwa, regwd, regrd1, regrd2);
    mod7 ALU(ALUop, irmux, regrd1, regrd2, immi, imms, ALUout, jt, bt);
    mod8 Memory(clk, rst, mwr, ALUout, memwd, memrd);
    mod9 mux4to1(ALUout, immu, memrd, pcnext, pc, wbmux, regwd)
endmodule