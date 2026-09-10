library verilog;
use verilog.vl_types.all;
entity top_sipo_alu is
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        shift_en        : in     vl_logic;
        serial_in       : in     vl_logic;
        alu_out         : out    vl_logic_vector(7 downto 0);
        a_is_zero       : out    vl_logic
    );
end top_sipo_alu;
