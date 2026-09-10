// Parallel-In Serial-Out (PISO) Shift Register
module piso_reg #(
    parameter WIDTH = 20,
    parameter ADDR_WIDTH = 8
)(
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire [WIDTH-1:0]      parallel_in,
    output reg                   en,
    output reg                   serial_out,
    output reg                   valid
);

    reg [WIDTH-1:0] shift_reg;
    reg [4:0]       count;
    reg             busy;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            en         <= 1'b0;
            serial_out <= 1'b0;
            valid      <= 1'b0;
            shift_reg  <= 'b0;
            count      <= 5'd0;
            busy       <= 1'b0;
        end 
        else begin
            if (!busy) begin
                // Issue read enable to RAM to fetch next word
                en    <= 1'b1;
                busy  <= 1'b1;
                valid <= 1'b0;
            end 
            else begin
                // Load parallel data once valid/available from RAM
                if (en) begin
                    shift_reg  <= parallel_in;
                    serial_out <= parallel_in[0]; // Driving LSB first
                    valid      <= 1'b1;
                    count      <= 5'd1;
                    en         <= 1'b0; // De-assert RAM enable during shifting
                end 
                else if (valid) begin
                    if (count < WIDTH) begin
                        serial_out <= shift_reg[count]; // Shift out bit by bit (LSB first)
                        count      <= count + 5'd1;
                    end 
                    else begin
                        // Done shifting full word
                        valid      <= 1'b0;
                        serial_out <= 1'b0;
                        busy       <= 1'b0; // Ready for next transaction
                    end
                end
            end
        end
    end

endmodule
