library verilog;
use verilog.vl_types.all;
entity UART_RX_TB is
    generic(
        DATA_WIDTH      : integer := 8;
        TX_CLK_PERIOD   : real    := 8.680000
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of DATA_WIDTH : constant is 1;
    attribute mti_svvh_generic_type of TX_CLK_PERIOD : constant is 1;
end UART_RX_TB;
