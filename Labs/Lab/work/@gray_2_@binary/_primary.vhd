library verilog;
use verilog.vl_types.all;
entity Gray_2_Binary is
    port(
        data_in         : in     vl_logic_vector(3 downto 0);
        data_out        : out    vl_logic_vector(3 downto 0)
    );
end Gray_2_Binary;
