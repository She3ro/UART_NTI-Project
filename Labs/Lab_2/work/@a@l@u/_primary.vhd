library verilog;
use verilog.vl_types.all;
entity ALU is
    generic(
        width           : integer := 8
    );
    port(
        a               : in     vl_logic_vector;
        b               : in     vl_logic_vector;
        opt             : in     vl_logic_vector(2 downto 0);
        \out\           : out    vl_logic_vector;
        zero            : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end ALU;
