// 20-bit RAM module to store test vectors
module ram #(
    parameter DATA_WIDTH = 20,
    parameter ADDR_WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire                  wr_en,
    input  wire [ADDR_WIDTH-1:0] addr,
    input  wire [DATA_WIDTH-1:0] din,
    input  wire                  rd_en,
    output reg  [DATA_WIDTH-1:0] dout,
    output reg                   valid
);

    // Memory array definition
    reg [DATA_WIDTH-1: 0] mem [255: 0];
    
    integer i;

    // Memory read/write sequential block
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            dout <= 'b0;
            valid <= 1'b0;
            // Clear memory on reset
            for (i = 0; i < (1<<ADDR_WIDTH); i = i + 1) begin
                mem[i] <= 'b0;
            end
        end 
        else begin
            // Write operation
            if (wr_en) begin
                mem[addr] <= din;
            end
            
            // Read operation
            if (rd_en) begin
                dout <= mem[addr];
                valid <= 1'b1;
            end 
            else begin
                valid <= 1'b0;
            end
        end
    end

endmodule
