library verilog;
use verilog.vl_types.all;
entity stp_chk is
    port(
        CLK             : in     vl_logic;
        RST             : in     vl_logic;
        sampled_bit     : in     vl_logic;
        Enable          : in     vl_logic;
        stp_err         : out    vl_logic
    );
end stp_chk;
