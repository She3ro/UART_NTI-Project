`timescale 1ns/1ps

module tb_top_sipo_alu;

    reg        clk;
    reg        rst_n;
    reg        shift_en;
    reg        serial_in;

    wire [7:0] alu_out;
    wire       a_is_zero;

    reg [19:0] test_word;
    reg        rand_alu_en;
    reg [2:0]  rand_opcode;
    reg [7:0]  rand_in_a;
    reg [7:0]  rand_in_b;
    
    reg [7:0]  expected_alu_out;
    reg        expected_a_is_zero;

    integer test_num;
    integer bit_idx;
    integer error_count;

    top_sipo_alu dut0 (
        .clk(clk),
        .rst_n(rst_n),
        .shift_en(shift_en),
        .serial_in(serial_in),
        .alu_out(alu_out),
        .a_is_zero(a_is_zero)
    );

  always #5 clk = ~clk;

    initial begin
        clk         = 0;
        rst_n       = 0;
        shift_en    = 0;
        serial_in   = 0;
        error_count = 0;

        #15;
        rst_n = 1; 
        #10;

        for (test_num = 1; test_num <= 10; test_num = test_num + 1) begin
            
            rand_alu_en = $urandom % 2;
            rand_opcode = $urandom % 8;
            rand_in_a   = $urandom % 256;
            rand_in_b   = $urandom % 256;

            if (test_num == 3) begin
                rand_in_a = 8'h00;
            end

            test_word = {rand_alu_en, rand_opcode, rand_in_a, rand_in_b};

            if (rand_in_a == 8'h00) begin
                expected_a_is_zero = 1'b1;
            end else begin
                expected_a_is_zero = 1'b0;
            end

            if (rand_alu_en == 1'b0) begin
                expected_alu_out = 8'h00;
            end else begin
                if (rand_opcode == 3'b000) begin
                    expected_alu_out = rand_in_a + rand_in_b; // ADD
                end else if (rand_opcode == 3'b001) begin
                    expected_alu_out = rand_in_a - rand_in_b; // SUB
                end else if (rand_opcode == 3'b010) begin
                    expected_alu_out = rand_in_a & rand_in_b; // AND
                end else if (rand_opcode == 3'b011) begin
                    expected_alu_out = rand_in_a ^ rand_in_b; // XOR
                end else if (rand_opcode == 3'b100) begin
                    expected_alu_out = rand_in_a | rand_in_b; // OR
                end else if (rand_opcode == 3'b101) begin
                    expected_alu_out = rand_in_a;             // OUT_A
                end else begin
                    expected_alu_out = 8'h00;                 // Default
                end
            end

            shift_en = 1'b1;
            for (bit_idx = 19; bit_idx >= 0; bit_idx = bit_idx - 1) begin
                serial_in = test_word[bit_idx];
                @(posedge clk);
            end
            shift_en = 1'b0;

            #5;

            if ((alu_out == expected_alu_out) && (a_is_zero == expected_a_is_zero)) begin
                $display("TEST %0d PASSED | Sent: %h | alu_out: %h | a_is_zero: %b", 
                         test_num, test_word, alu_out, a_is_zero);
            end 
            else begin
                $display("TEST %0d FAILED | Sent: %h", test_num, test_word);
                $display("  Expected: alu_out = %h, a_is_zero = %b", expected_alu_out, expected_a_is_zero);
                $display("  Actual:   alu_out = %h, a_is_zero = %b", alu_out, a_is_zero);
                error_count = error_count + 1;
            end

            #10;
        end

endmodule