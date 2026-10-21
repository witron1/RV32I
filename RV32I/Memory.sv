module memory (
    input logic clk,
    input logic nrst,
    input logic we,
    input logic [31:0] addr,
    input logic [31:0] wd,
    output logic [31:0] rd
);
    logic [31:0] memcell [0:4095];
    assign rd = memcell[addr];
    always_ff @( clk ) begin : memorywrite
        if (nrst) begin
            for (int i = 0; i < 4095; i++) begin
                memcell[i] <= 0;
            end
        end
            else if (we)
            memcell[addr] <= wd;
            
    end
endmodule