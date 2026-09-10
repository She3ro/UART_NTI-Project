// Top-Level Module integrating RAM, PISO, SIPO, and ALU
module Sys_Top #(
    parameter DATA_WIDTH = 20,
    parameter ADDR_WIDTH = 8,
    parameter ALU_WIDTH  = 8
)(
    input  wire                  clk,
    input  wire                  rst_n,
    input  wire                  wr_en,
    input  wire [ADDR_WIDTH-1:0] addr,
    input  wire [DATA_WIDTH-1:0] din,
    output wire [ALU_WIDTH-1:0]  alu_out,
    output wire                  a_is_zero
);

    // Wires for inter-module connections
    wire [DATA_WIDTH-1:0] ram_dout;
    wire                  ram_rd_en;
    wire                  ram_valid;
    wire                  serial_data;
    wire                  piso_valid;
    wire [DATA_WIDTH-1:0] sipo_parallel_out;

    // Bit-Field extraction from SIPO parallel output
    wire                  alu_en;
    wire [2:0]            opcode;
    wire [ALU_WIDTH-1:0]  in_a;
    wire [ALU_WIDTH-1:0]  in_b;

    assign alu_en = sipo_parallel_out[19];
    assign opcode = sipo_parallel_out[18:16];
    assign in_a   = sipo_parallel_out[15:8];
    assign in_b   = sipo_parallel_out[7:0];

    // RAM Instantiation
    ram #(
        .DATA_WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_ram (
        .clk   (clk),
        .rst_n (rst_n),
        .wr_en (wr_en),
        .addr  (addr),
        .din   (din),
        .rd_en (ram_rd_en),
        .dout  (ram_dout),
        .valid (ram_valid)
    );

    // PISO Instantiation
    piso_reg #(
        .WIDTH(DATA_WIDTH),
        .ADDR_WIDTH(ADDR_WIDTH)
    ) u_piso (
        .clk         (clk),
        .rst_n       (rst_n),
        .parallel_in (ram_dout),
        .en          (ram_rd_en),
        .serial_out  (serial_data),
        .valid       (piso_valid)
    );

    // SIPO Instantiation
    sipo_reg #(
        .WIDTH(DATA_WIDTH)
    ) u_sipo (
        .clk          (clk),
        .rst_n        (rst_n),
        .shift_en     (piso_valid),
        .serial_in    (serial_data),
        .parallel_out (sipo_parallel_out)
    );

    // ALU Instantiation
    alu #(
        .WIDTH(ALU_WIDTH)
    ) u_alu (
        .in_a      (in_a),
        .in_b      (in_b),
        .opcode    (opcode),
        .alu_en    (alu_en),
        .alu_out   (alu_out),
        .a_is_zero (a_is_zero)
    );

endmodule
