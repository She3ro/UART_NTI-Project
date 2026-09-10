library verilog;
use verilog.vl_types.all;
entity parity_calc is
    generic(
        WIDTH           : integer := 8
    );
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        parity_enable   : in     vl_logic;
        parity_type     : in     vl_logic;
        Busy            : in     vl_logic;
        DATA            : in     vl_logic_vector;
        Data_Valid      : in     vl_logic;
        parity          : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of WIDTH : constant is 1;
end parity_calc;
