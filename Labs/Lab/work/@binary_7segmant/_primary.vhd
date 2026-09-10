library verilog;
use verilog.vl_types.all;
entity Binary_7segmant is
    port(
        data_in         : in     vl_logic_vector(3 downto 0);
        data_out_external: out    vl_logic_vector(3 downto 0)
    );
end Binary_7segmant;
