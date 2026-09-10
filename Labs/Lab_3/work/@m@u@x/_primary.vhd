library verilog;
use verilog.vl_types.all;
entity MUX is
    generic(
        width           : integer := 5
    );
    port(
        in0             : in     vl_logic_vector;
        in1             : in     vl_logic_vector;
        sel             : in     vl_logic;
        \out\           : out    vl_logic_vector
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of width : constant is 1;
end MUX;
