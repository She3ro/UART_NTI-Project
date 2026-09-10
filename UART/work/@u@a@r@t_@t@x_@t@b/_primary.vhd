library verilog;
use verilog.vl_types.all;
entity UART_TX_TB is
    generic(
        DATA_WD_TB      : integer := 8;
        CLK_PERIOD      : real    := 8.680000
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WD_TB : constant is 1;
    attribute mti_svvh_generic_type of CLK_PERIOD : constant is 1;
end UART_TX_TB;
