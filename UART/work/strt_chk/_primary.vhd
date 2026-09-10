library verilog;
use verilog.vl_types.all;
entity strt_chk is
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        sampled_bit     : in     vl_logic;
        Enable          : in     vl_logic;
        strt_glitch     : out    vl_logic
    );
end strt_chk;
