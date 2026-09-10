library verilog;
use verilog.vl_types.all;
entity Sys_Top is
    generic(
        DATA_WIDTH      : integer := 20;
        ADDR_WIDTH      : integer := 8;
        ALU_WIDTH       : integer := 8
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        wr_en           : in     vl_logic;
        addr            : in     vl_logic_vector;
        din             : in     vl_logic_vector;
        alu_out         : out    vl_logic_vector;
        a_is_zero       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ADDR_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of ALU_WIDTH : constant is 1;
end Sys_Top;
