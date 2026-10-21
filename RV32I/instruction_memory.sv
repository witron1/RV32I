module instruction_memory (
    input logic [31:0] pc_count,
    output logic [31:0] instr
);
    logic [31:0] mem [0:4095] ;
    assign instr = mem[pc_count];
endmodule