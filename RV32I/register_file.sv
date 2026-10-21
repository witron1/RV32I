module regfile (
    input logic nrst,
    input logic clk,
    input logic we,
    input logic [4:0] ra1,
    input logic [4:0] ra2,
    input logic [4:0] wa,
    input logic [31:0] wd,
    output logic [31:0] rs1,
    output logic [31:0] rs2
);
    logic [31:0] regs [31:0] ;
    assign rs1 = (ra1 == 0) ? 32'd0 : regs[ra1];
    assign rs2 = (ra2 == 0) ? 32'd0 : regs[ra2];
    always_ff @(posedge clk) begin : regfile
        if (!nrst) begin
            for (int i = 0; i < 32; i++) begin
                regs[i] <= 0;
            end
    end
        else if (we && wa != 0) begin
            regs[wa] <= wd;
        
        end
            
    end
endmodule